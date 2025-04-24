#! /usr/bin/env python
import os
import sys
import requests
import json

# Load API token and Project ID from environment variables
API_TOKEN = os.getenv('PIVOTAL_TRACKER_API_TOKEN')
PROJECT_ID = os.getenv('PIVOTAL_TRACKER_PROJECT_ID')

if not API_TOKEN or not PROJECT_ID:
    raise ValueError("Please set the PIVOTAL_TRACKER_API_TOKEN and PIVOTAL_TRACKER_PROJECT_ID environment variables.")

# Check if destination folder is provided as a command line argument
if len(sys.argv) < 2:
    raise ValueError("Please provide a destination folder as a command line argument.")

DESTINATION_FOLDER = sys.argv[1]

# Ensure the destination folder exists
if not os.path.exists(DESTINATION_FOLDER):
    os.makedirs(DESTINATION_FOLDER)

# Base URL for the Pivotal Tracker API
BASE_URL = f'https://www.pivotaltracker.com/services/v5/projects/{PROJECT_ID}'

# Headers with authorization token
headers = {
    'X-TrackerToken': API_TOKEN,
    'Content-Type': 'application/json'
}

def fetch_all_data(endpoint):
    """Fetch all paginated data from the Pivotal Tracker API."""
    url = f'{BASE_URL}/{endpoint}'
    data = []
    limit = 100  # Max number of items per page according to Pivotal Tracker API docs
    offset = 0

    while True:
        params = {
            'limit': limit,
            'offset': offset
        }
        response = requests.get(url, headers=headers, params=params)

        if response.status_code == 200:
            items = response.json()
            if not items:  # No more data to fetch
                break
            data.extend(items)
            offset += limit
        else:
            print(f"Failed to fetch {endpoint}: {response.status_code} - {response.text}")
            break

    return data

def fetch_without_pagination(endpoint):
    """Fetch data from an endpoint that doesn't support pagination."""
    url = f'{BASE_URL}/{endpoint}'
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to fetch {endpoint}: {response.status_code} - {response.text}")
        return []

def download_attachments(data):
    attachments_folder = os.path.join(DESTINATION_FOLDER, 'attachments')
    if not os.path.exists(attachments_folder):
        os.makedirs(attachments_folder)

    for item in data:
        if 'attachments' not in item:
            continue

        for attachment in item['attachments']:
            if 'kind' in attachment and attachment['kind'] == 'file_attachment':
                attachment_id = attachment['id']
                attachment_url = attachment['download_url']
                attachment_filename = attachment['filename']

                attachment_folder = os.path.join(attachments_folder, f"{attachment_id}")
                attachment_path = os.path.join(attachment_folder, attachment_filename)
                if os.path.exists(attachment_path):
                    print(f"Skipped. Attachment {attachment_filename} already exists in {attachment_path}")
                    continue

                url = f'https://www.pivotaltracker.com/{attachment_url}'
                attachment_response = requests.get(url, headers=headers)

                if attachment_response.status_code == 200:
                    if not os.path.exists(attachment_folder):
                        os.makedirs(attachment_folder)
                    with open(attachment_path, 'wb') as attachment_file:
                        attachment_file.write(attachment_response.content)
                    print(f"Downloaded attachment {attachment_filename} to {attachment_path}")
                else:
                    print(f"Failed to download attachment {attachment_filename}: {attachment_response.status_code}")

def save_data(filename, data):
    """Save data to a JSON file."""
    if data:
        filepath = os.path.join(DESTINATION_FOLDER, filename)
        with open(filepath, 'w') as f:
            json.dump(data, f, indent=4)
        print(f"Data saved to {filepath}")
        return True
    else:
        print(f"No data found for {endpoint}")
        return False

def fetch_memberships(filename):
    """Fetch memberships and save it to a JSON file, without pagination."""
    data = fetch_without_pagination(endpoint='memberships')
    save_data(filename, data)

def fetch_epics(filename):
    """Fetch epics and save it to a JSON file, without pagination."""
    data = fetch_without_pagination(endpoint='epics')
    save_data(filename, data)

def fetch_story_comments(filename, story_data):
    """Fetch story comment data and save it to a JSON file."""
    comments = []
    for story in story_data:
        story_id = story.get('id')
        if story_id:
            endpoint = f'stories/{story_id}/comments?fields=:default,attachments'
            story_comments = fetch_without_pagination(endpoint)
            if story_comments:
                download_attachments(story_comments)
            comments.extend(story_comments)
    save_data(filename, comments)

def fetch_story_tasks(filename, story_data):
    """Fetch story task data and save it to a JSON file."""
    tasks = []
    for story in story_data:
        story_id = story.get('id')
        if story_id:
            endpoint = f'stories/{story_id}/tasks'
            story_tasks = fetch_without_pagination(endpoint)
            tasks.extend(story_tasks)
    save_data(filename, tasks)

def fetch_stories(filename):
    """Fetch story data and save it to a JSON file, with pagination."""
    data = fetch_all_data(endpoint='stories')
    if save_data(filename, data):
        fetch_story_tasks('tasks.json', data)
        fetch_story_comments('comments.json', data)

def fetch_activity(filename):
    """Fetch activity data and save it to a JSON file, with pagination."""
    data = fetch_all_data(endpoint='activity')
    save_data(filename, data)

fetch_memberships('memberships.json')
fetch_epics('epics.json')
fetch_stories('stories.json')
fetch_activity('activities.json')
print("Backup complete!")

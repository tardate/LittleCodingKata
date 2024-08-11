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

def fetch_and_save(endpoint, filename, paginate=True):
    """Fetch data and save it to a JSON file, with optional pagination."""
    if paginate:
        data = fetch_all_data(endpoint)
    else:
        data = fetch_without_pagination(endpoint)

    if data:
        filepath = os.path.join(DESTINATION_FOLDER, filename)
        with open(filepath, 'w') as f:
            json.dump(data, f, indent=4)
        print(f"Data saved to {filepath}")

    else:
        print(f"No data found for {endpoint}")

# Backup stories (with pagination)
fetch_and_save('stories', 'stories_backup.json', paginate=True)

# Backup epics (without pagination)
fetch_and_save('epics', 'epics_backup.json', paginate=False)

# Backup activities (with pagination and attachment download)
fetch_and_save('activity', 'activities_backup.json', paginate=True)

print("Backup complete!")

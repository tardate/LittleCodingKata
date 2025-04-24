# #296 PT Backup

How to script a simple Pivotal Tracker backup with python and the RESTful API

## Notes

[Pivotal Tracker](https://www.pivotaltracker.com/) does not have a built-in feature for direct project backups, but you can use its API to fetch and store project data.

See [pt_backup.py](./pt_backup.py) for an example of a script to perform such a backup. It covers:

* epics
* stories
* story comments including file attachments
* story tasks
* story activity
* project memberships

## Method/Algorithms

Epics

* Get all epics for a projects
* <https://www.pivotaltracker.com/help/api/rest/v5#Epics>
* `GET /projects/{project_id}/epics`
* does not support pagination

Stories

* Get all stories for a project
* <https://www.pivotaltracker.com/help/api/rest/v5#Stories>
* `GET /projects/{project_id}/stories`
* supports pagination (required for most real-world projects)

Story activity

* Get all stories for a project
* <https://www.pivotaltracker.com/help/api/rest/v5#Activity>
* `GET /projects/{project_id}/activity`
* supports pagination (required for most real-world projects)
* history is limited:
    * most recent six months for any non-Enterprise subscription plan
    * last 25 months of activity for an Enterprise subscription plan
* Note: I originally tried to download attachments based on activity until I noted the limited horizon

Story Comments

* Get all comments for all stories in a project
* <https://www.pivotaltracker.com/help/api/rest/v5#Comments>
* `GET /projects/{project_id}/stories/{story_id}/comments`
* does not support pagination
* attachment ids are not included in the response by default. Request `fields=:default,attachments` to get full attachment details in the response
    * download attachments based on the attachments collection for each comment

Story Tasks

* Get all tasks for all stories in a project
* <https://www.pivotaltracker.com/help/api/rest/v5#Story_Tasks>
* `GET /projects/{project_id}/stories/{story_id}/tasks`
* does not support pagination

Project memberships

* Get all memberships for a project
* <https://www.pivotaltracker.com/help/api/rest/v5#Project_Memberships>
* `GET /projects/{project_id}/memberships`
* does not support pagination

## Running the Script

Install the required packages using pip:

    pip install -r requirements.txt

The script expects the Pivotal Tracker API token and project ID to be provided as environment variables:

    export PIVOTAL_TRACKER_API_TOKEN='your_api_token_here'
    export PIVOTAL_TRACKER_PROJECT_ID='your_project_id_here'

To run the script:

    $ PIVOTAL_TRACKER_API_TOKEN=my-token PIVOTAL_TRACKER_PROJECT_ID=my-id ./pt_backup.py /MyBackups
    Data saved to /MyBackups/memberships.json
    Data saved to /MyBackups/epics.json
    Data saved to /MyBackups/stories.json
    Data saved to /MyBackups/tasks.json
    Data saved to /MyBackups/comments.json
    Data saved to /MyBackups/activities.json
    Backup complete!

## Credits and References

* [Pivotal Tracker](https://www.pivotaltracker.com/)
* [API Documentation](https://www.pivotaltracker.com/help/api/)

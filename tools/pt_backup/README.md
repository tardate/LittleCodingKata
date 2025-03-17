# #296 PT Backup

How to script a simple Pivotal Tracker backup with python and the RESTful API

## Notes

[Pivotal Tracker](https://www.pivotaltracker.com/) does not have a built-in feature for direct project backups, but you can use its API to fetch and store project data.

See [pt_backup.py](./pt_backup.py) for an example of a script to perform such a backup. It covers:

* epics
* stories
* story activity
* activity attachment

## Running the Script

Install the required packages using pip:

    pip install -r requirements.txt

The script expects the Pivotal Tracker API token and project ID to be provided as environment variables:

    export PIVOTAL_TRACKER_API_TOKEN='your_api_token_here'
    export PIVOTAL_TRACKER_PROJECT_ID='your_project_id_here'

To run the script:

    $ PIVOTAL_TRACKER_API_TOKEN=my-token PIVOTAL_TRACKER_PROJECT_ID=my-id ./pt_backup.py /MyBackups
    Data saved to /MyBackups/stories_backup.json
    Data saved to /MyBackups/epics_backup.json
    Data saved to /MyBackups/activities_backup.json

## Credits and References

* [Pivotal Tracker](https://www.pivotaltracker.com/)
* [API Documentation](https://www.pivotaltracker.com/help/api/)

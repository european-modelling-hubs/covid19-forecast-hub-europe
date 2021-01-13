import os
import json
import requests

def send_notification(title, message, details, link, color='danger'):
    webhook = os.environ['SLACK_WEBHOOK']
    
    slack_data={
        "attachments": [
            {
            "mrkdwn_in": ["text"],
                "color": color,
                #"author_name": "Data Bot",
                "title": title,
                "title_link": link,
                "fields": [
                    {
                        "title": message,
                        "value": details,
                        "short": False
                    }
                ]
            }
        ]
    }
    response = requests.post(
        webhook, data = json.dumps(slack_data),
        headers={'Content-Type': 'application/json'}
    )
    if response.status_code != 200:
        raise ValueError(
            'Request to slack returned an error %s, the response is:\n%s'
            % (response.status_code, response.text)
            )
        
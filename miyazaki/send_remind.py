#coding:utf-8
import requests, os

slack_token = os.environ['SLACK_REGACY_TOKEN']

def get_channel_list():
    headers = {
            'Authorization': 'Bearer %s' % slack_token,
            'content-type' : 'application/json'
            }
    url = 'https://slack.com/api/channels.list'
    res = requests.get(url, headers = headers).json()

    channel_name_to_id = {}
    for channel_data in res['channels']:
        channel_name = channel_data['name']
        channel_id   = channel_data['id']
        channel_name_to_id[channel_name] = channel_id

    return channel_name_to_id

if __name__ == '__main__':
    channel_name_to_id = get_channel_list()


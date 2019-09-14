#coding:utf-8
import requests, os

slack_token = os.environ['SLACK_REGACY_TOKEN']

def set_remind(remind_date, mtg_date, channel_id, channel_name):
    headers = {
            'Authorization': 'Bearer %s' % slack_token,
            }
    url = 'https://slack.com/api/chat.command'

    message = '#%s on %s to %sからMTGやります' % (channel_name, remind_date, mtg_date)
    print(message)

    payload = {
            'channel' : channel_id,
            'command' : '/remind',
            'text'    : message,
            'as_user' : True
            }

    res = requests.post(url, headers = headers, data = payload)
    print(res.text)

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

    remind_month = '9'
    remind_day   = '30'
    remind_time  = '9:00'
    remind_AM_PM = 'PM'

    mtg_month = '9'
    mtg_day   = '31'
    mtg_time  = '9:00'
    mtg_AM_PM = 'PM'

    channel_name = 'botrensyuu'
    channel_id   = channel_name_to_id[channel_name]

    remind_date = '%s/%s %s %s' % (remind_month, remind_day, remind_time, remind_AM_PM)
    mtg_date    = '%s/%s %s %s' % (mtg_month, mtg_day, mtg_time, mtg_AM_PM)

    set_remind(remind_date, mtg_date, channel_id, channel_name)



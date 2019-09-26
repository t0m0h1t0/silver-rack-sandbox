# slack bot

## get channel list

Each Slack channel has slack id.

We can get the slack channel id using this method and know the correspondence between Slack channel name and Slack channel ID.

## set remind

We can set remind on channel we designate using this method.

We have to pass 4 argument.

1. remind_data  : the date when Slackbot notifies a reminder.
    - ex.) 9/30 9:00 PM
2. mtg_data     : the date when the meeting starts.
    - ex.) 10/1 9:00 PM
3. channel id   : the id We have got using get_channel_list() that is explained above.
4. channel name : the channel name of channel we want to set remind to.

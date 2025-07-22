{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
in
{
  # Wrapper for Emacs client using daemon
  "${xdg_dataHome}/bin/emacsclient" = {
    executable = true;
    text = ''
#!/bin/zsh
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run Emacs
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Emacs
# @raycast.icon ${xdg_dataHome}/img/icons/Emacs.icns
# @raycast.iconDark ${xdg_dataHome}/img/icons/Emacs.icns

if [[ $$1 = "-t" ]]; then
  ${pkgs.emacs}/bin/emacsclient -t "$$@"
else
  ${pkgs.emacs}/bin/emacsclient -c -n "$$@"
fi
    '';
  };

  # Script to show next meeting status in tmux
  "${xdg_dataHome}/.config/tmux/scripts/cal.sh" = {
    executable = true;
    text = ''
#!/bin/bash

ALERT_IF_IN_NEXT_MINUTES=10
ALERT_POPUP_BEFORE_SECONDS=10
NERD_FONT_FREE="󱁕 "
NERD_FONT_MEETING="󰤙"

get_attendees() {
  attendees=$$(
    icalBuddy \
      --includeEventProps "attendees" \
      --propertyOrder "datetime,title" \
      --noCalendarNames \
      --dateFormat "%A" \
      --includeOnlyEventsFromNowOn \
      --limitItems 1 \
      --excludeAllDayEvents \
      --separateByDate \
      --excludeEndDates \
      --bullet "" \
      --excludeCals "training,omerxx@gmail.com" \
      eventsToday)
}

parse_attendees() {
  attendees_array=()
  for line in $$attendees; do
    attendees_array+=("$$line")
  done
  number_of_attendees=$$(($${#attendees_array[@]}-3))
}

get_next_meeting() {
  next_meeting=$$(icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%A" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    --excludeCals "training,omerxx@gmail.com" \
    eventsToday)
}

get_next_next_meeting() {
  end_timestamp=$$(date +"%Y-%m-%d $${end_time}:01 %z")
  tonight=$$(date +"%Y-%m-%d 23:59:00 %z")
  next_next_meeting=$$(
    icalBuddy \
      --includeEventProps "title,datetime" \
      --propertyOrder "datetime,title" \
      --noCalendarNames \
      --dateFormat "%A" \
      --limitItems 1 \
      --excludeAllDayEvents \
      --separateByDate \
      --bullet "" \
      --excludeCals "training,omerxx@gmail.com" \
      eventsFrom:"$${end_timestamp}" to:"$${tonight}")
}

parse_result() {
  array=()
  for line in $$1; do
    array+=("$$line")
  done
  time="$${array[2]}"
  end_time="$${array[4]}"
  title="$${array[*]:5:30}"
}

calculate_times() {
  epoc_meeting=$$(date -j -f "%T" "$${time}:00" +%s)
  epoc_now=$$(date +%s)
  epoc_diff=$$((epoc_meeting - epoc_now))
  minutes_till_meeting=$$((epoc_diff/60))
}

display_popup() {
  tmux display-popup \
    -S "fg=#eba0ac" \
    -w50% \
    -h50% \
    -d '#{pane_current_path}' \
    -T meeting \
    icalBuddy \
      --propertyOrder "datetime,title" \
      --noCalendarNames \
      --formatOutput \
      --includeEventProps "title,datetime,notes,url,attendees" \
      --includeOnlyEventsFromNowOn \
      --limitItems 1 \
      --excludeAllDayEvents \
      --excludeCals "training" \
      eventsToday
}

print_tmux_status() {
  if [[ $$minutes_till_meeting -lt $$ALERT_IF_IN_NEXT_MINUTES && $$minutes_till_meeting -gt -60 ]]; then
    echo "$$NERD_FONT_MEETING $${time} $${title} ($${minutes_till_meeting} minutes)"
  else
    echo "$$NERD_FONT_FREE"
  fi

  if [[ $$epoc_diff -gt $$ALERT_POPUP_BEFORE_SECONDS && $$epoc_diff -lt $$(($$ALERT_POPUP_BEFORE_SECONDS+10)) ]]; then
    display_popup
  fi
}

main() {
  get_attendees
  parse_attendees
  get_next_meeting
  parse_result "$${next_meeting}"
  calculate_times
  if [[ "$${next_meeting}" != "" && $${number_of_attendees} -lt 2 ]]; then
    get_next_next_meeting
    parse_result "$${next_next_meeting}"
    calculate_times
  fi
  print_tmux_status
  # echo "$${minutes_till_meeting} | $${number_of_attendees}"
}

main
    '';
  };
}


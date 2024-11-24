json.friends_sleep_records @following_sleep_records do |record|
  json.id record.id
  json.user_id record.user_id
  json.user_name record.user_name
  json.clock_in record.clock_in
  json.clock_out record.clock_out
  json.duration record.duration
end

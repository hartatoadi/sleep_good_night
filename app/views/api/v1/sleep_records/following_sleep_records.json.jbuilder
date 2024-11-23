json.array! @following_sleep_records do |record|
  json.id record.id
  json.user_id record.user_id
  json.clock_in record.clock_in
  json.clock_out record.clock_out
  json.duration record.duration
end

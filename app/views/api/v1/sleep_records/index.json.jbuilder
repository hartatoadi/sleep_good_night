json.sleep_records @my_sleep_records do |sleep_record|
  json.id sleep_record.id
  json.clock_in sleep_record.clock_in
  json.clock_out sleep_record.clock_out
  json.duration sleep_record.duration
end

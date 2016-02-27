munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, info_hash|
  case info_hash["age"]
  when 0..18
    info_hash["age_group"] = "kid"
  when 18..65
    info_hash["age_group"] = "adult"
  else
    info_hash["age_group"] = "senior"
  end
end

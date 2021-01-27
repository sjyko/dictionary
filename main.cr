require "kemal"
require "yaml"

words = Hash(String, String).from_yaml File.open("gen.yml")
particles = Hash(String, String).from_yaml File.open("particles.yml")
words.merge! particles

get "/" do |env|
    send_file env, "public/index.html"
end

post "/define" do |env|
    word = env.params.json["word"].to_s.downcase
    out_keys = words.keys.reject { |x| !(x.downcase.includes? word) }.map { |x| words[x] }
    out_keys.map! { |x| "#{words.invert[x]}: #{x}" }
    out_vals = words.invert.keys.reject { |x| !(x.downcase.includes? word) }.map { |x| words.invert[x] }
    out_vals.map! { |x| "#{x}: #{words[x]}" }
    (out_keys + out_vals).to_json
end

Kemal.run

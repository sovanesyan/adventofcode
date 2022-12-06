require 'json'
require 'cgi'
require 'net/https'

URL = "https://adventofcode.com/2021/leaderboard/private/view/1057703.json"
SESSION_COOKIE = "53616c7465645f5f1e563c2d91fa5d81e3bc6e52b2d344f0af60e05467257548132d2e4541ef1fb5ec359389ae2d9ce6"

def get_leaderboard
    uri = URI(URL)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new(uri.request_uri)
        cookie1 = CGI::Cookie.new('session', SESSION_COOKIE)
        request['Cookie'] = cookie1.to_s 
        return JSON.parse(http.request(request).body)
    end
end

def lambda_handler(event:, context:)
    unless File.exists? "advent"
        response = get_leaderboard
        File.write("advent", JSON.generate(response))
    end
    response = JSON.parse(File.read("advent"))

    result = response["members"].map { |x| x[1]}
                                .sort_by { |x| x["local_score"].to_i } 
                                .reverse

    leaderboard = result.map.with_index do |x, i| 
        { 
            name: x["name"],
            position: (i+1).to_s,
            points: x["local_score"].to_s,
            stars: (1...25).map do |day| 
                complete_day = x["completion_day_level"][day.to_s]
                unless complete_day
                    " " 
                else
                complete_day && complete_day.has_key?("2") ? "*" : "/"
                end
            end.join
        }
    end
    max_position = leaderboard.map { |x| x[:position].size }.max
    max_points = leaderboard.map { |x| x[:points].size }.max.to_i
    max_stars = leaderboard.map { |x| x[:stars] }.max.to_i

    response_text = leaderboard.map do |participant|
        position = participant[:position].rjust(max_position)
        points = participant[:points].rjust(max_points)
        stars = participant[:stars].ljust(max_stars)
        name = participant[:name]
        "#{position}) #{points} #{stars} #{name}"
    end
    
    { 
        statusCode: 200, 
        body: JSON.generate({
            response_type: "in_channel",
            text: "```"+response_text.join("\n")+"```"
        }) 
    }
end

lambda_handler(event:nil, context:nil)


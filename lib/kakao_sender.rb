require 'faraday'
require 'json'

class KakaoSender
  def initialize
    @req = Faraday.new(url: 'https://dev-alimtalk-api.bizmsg.kr:1443/')
    # https://alimtalk-api.bizmsg.kr/
  end

  def send_message
    response = @req.post do |req|
      req.url '/v1/sender/send'
      req.headers['Content-Type'] = 'application/json'
      req.body = payload.to_json
    end
    response.body
  end

  def payload
    payload_json = <<-JSON
    {
      "userId": "prepay_user",
      "message_type": "at",
      "phn": "821064184332",
      "profile": "89823b83f2182b1e229c2e95e21cf5e6301eed98",
      "tmplId": "alimtalktest_003",
      "msg": "회원가입안내",
      "smsKind": "N",
      "msgSms": "회원가입안내",
      "smsSender": "01064184332",
      "smsLmsTit": "회원가입안내",
      "button1": {
        "name":"배송조회하기",
        "type":"DS"
      }
    }
    JSON
    payload = []
    payload << JSON.parse(payload_json)
    고객명 = '이원섭'
    택배회사명 = '고구마택배'
    시간 = '오늘 3시에서 6시 사이에'
    운송장번호 = '19830508'
    message = <<-TEXT
#{고객명} 고객님! #{택배회사명}입니다.
#{시간} 택배를 배달할 예정입니다.
등기번호(운송장번호) : #{운송장번호}
    TEXT
    puts message
    payload[0]["msg"] = message
    payload
  end
end

kakao = KakaoSender.new
puts kakao.send_message

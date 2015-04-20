module.exports = (robot) ->
  robot.hear /^bus (\w+)( (\d+))?/i, (msg) ->
    strList = nextBus(msg.match[1], msg.match[2], msg)
    if strList.length > 0
      msg.send strList
    else
      msg.send "本日の運行は終了しました"

nextBus = (dest, count, msg) ->
  return if !destAvailable(dest)
  count = parseInt(count, 10) || 3
  count = Math.min(5, count)
  count = Math.max(1, count)
  current = new Date()
  hour = current.getHours()
  min = current.getMinutes()
  dict = timeDict(current.getDay() == 0 || current.getDay() == 6)

  num = 0
  timeStrList = []
  while count > num
    break if hour > 23
    if dict[hour]?
      list = []
      for key in keysFromDestination(dest)
        list = list.concat dict[hour][key]
      list.sort()
      for time in list
        break if num >= count
        if time > min
          timeStrList.push("#{hour}時#{time}分")
          num++
    min = -1
    hour++
  timeStrList

destAvailable = (dest) ->
  dest == "kita" || dest == "gaku" || dest == "taka"

keysFromDestination = (dest) ->
  dict = {
    "kita" : ["kita", "gaku"]
    "gaku" : ["gaku"]
    "taka" : ["taka"]
  }
  dict[dest]

timeDict = (holiday) ->
  if !holiday
    dict = {
      6   : {"kita" : [],         "gaku" : [16,52],   "taka" : [17]}
      7   : {"kita" : [20,44],    "gaku" : [39],      "taka" : [19]}
      8   : {"kita" : [7,17,49],  "gaku" : [24],      "taka" : [29]}
      9   : {"kita" : [],         "gaku" : [12],      "taka" : [15]}
      10  : {"kita" : [],         "gaku" : [2],       "taka" : [12]}
      11  : {"kita" : [],         "gaku" : [2],       "taka" : [38]}
      12  : {"kita" : [],         "gaku" : [2],       "taka" : []}
      13  : {"kita" : [],         "gaku" : [2],       "taka" : [38]}
      14  : {"kita" : [],         "gaku" : [2],       "taka" : []}
      15  : {"kita" : [],         "gaku" : [12],      "taka" : [13]}
      16  : {"kita" : [],         "gaku" : [2],       "taka" : [48]}
      17  : {"kita" : [17,57],    "gaku" : [0,43],    "taka" : [36]}
      18  : {"kita" : [24,49],    "gaku" : [7,37],    "taka" : [54]}
      19  : {"kita" : [29],       "gaku" : [2],       "taka" : [38]}
      20  : {"kita" : [27,56],    "gaku" : [6],       "taka" : [48]}
      21  : {"kita" : [],         "gaku" : [32],      "taka" : []}
      22  : {"kita" : [2],        "gaku" : [],        "taka" : []}
    }
  else
    dict = {
      6   : {"kita" : [16],       "gaku" : [49],      "taka" : []}
      7   : {"kita" : [58],       "gaku" : [28],      "taka" : []}
      8   : {"kita" : [24, 49],   "gaku" : [],        "taka" : [29]}
      9   : {"kita" : [],         "gaku" : [22],      "taka" : [15]}
      10  : {"kita" : [],         "gaku" : [],        "taka" : [12]}
      11  : {"kita" : [],         "gaku" : [2],       "taka" : [38]}
      12  : {"kita" : [],         "gaku" : [],        "taka" : []}
      13  : {"kita" : [],         "gaku" : [2],       "taka" : [38]}
      14  : {"kita" : [],         "gaku" : [],        "taka" : []}
      15  : {"kita" : [],         "gaku" : [12],      "taka" : [13]}
      16  : {"kita" : [],         "gaku" : [],        "taka" : [48]}
      17  : {"kita" : [17,47],    "gaku" : [1],       "taka" : [36]}
      18  : {"kita" : [17,57],    "gaku" : [31],      "taka" : [54]}
      19  : {"kita" : [27,56],    "gaku" : [],        "taka" : []}
      20  : {"kita" : [27,57],    "gaku" : [],        "taka" : []}
      21  : {"kita" : [27],       "gaku" : [],        "taka" : []}
      22  : {"kita" : [],         "gaku" : [],        "taka" : []}
    }

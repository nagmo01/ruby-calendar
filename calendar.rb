require "date"
require "optparse"

opt = OptionParser.new
opt.on('-m')
opt.parse!(ARGV)

#current_dateに今年、今月、今日を代入
current_date = Date.today
#引数有りで実行された場合そのままinputに代入
#引数無しで実行された場合今月をinputに代入（文字列に直す）
if ARGV[0] != nil
  input = ARGV[0]
else
  input = current_date.month.to_s
end

#input（引数）が1~12の範囲内であるかどうかを確認する（引数無しは1~12に絶対含まれる）
#includeで確認するときに整数で確認するとto_sを使うことになり、引数が少数だった場合に整数にしてしまうので文字列のままincludeで確認します。
array = (1..12).map(&:to_s)
if array.include?(input)
  year = current_date.year
  month = input.to_i
else
  puts "#{input} is neither a month number (1..12) nor a name"
  exit
end

#日曜始まりでの月初日を取得
month_start = Date.new(year, month, 1).wday

#日曜始まりを月曜始まりに直す。
month_start = (month_start == 0) ? 6 : month_start - 1

#月末日を取得
last_day = Date.new(year, month, -1).day

#カレンダー表示の処理

puts "      #{input}月 #{year}"

puts "月 火 水 木 金 土 日\n"

#iは実際にカレンダーの日数を出力したときに加算していくカウンタ
#dはループ回数自体で加算していくカウンタにしていて、月〜日の７回ごとに改行を挟むために利用します。
i = 1
d = 1

while i <= last_day

  if d <= month_start
    print "   "

  else
    printf("%2d", i)
    print " "
    i += 1
  end

  if d % 7 == 0
    print "\n"
  end

  d += 1

end

require "date"
require "optparse"

opt = OptionParser.new
opt.on('-m')
opt.parse!(ARGV)

#current_dateに今年、今月、今日を代入
current_date = Date.today
#inputにコマンドライン引数を代入
input = ARGV[0]

#受け取った引数が整数値判別する
if input != nil
  #引数の文字列が整数か確認(少数も省く）
  if input =~ /\A-?\d+\z/
    #引数が1-12に収まっているか確認
    if input.to_i >= 1 && input.to_i <= 12
      year = current_date.year
      puts "      #{input}月 #{year}"
      month = input.to_i
    else
      puts "#{input} is neither a month number (1..12) nor a name"
      exit

    end

  else
    puts "#{input} is neither a month number (1..12) nor a name"
    exit
  end

#引数なしの場合当月を表示する
else
  year = current_date.year
  month = current_date.month
  puts "      #{month}月 #{year}"
end





#これで当月の初日が何曜日かわかる 0=日曜日
wday = Date.new(current_date.year, month, 1).wday
#これで最終日が何日かを取得
last_day = Date.new(current_date.year, month, -1).day
#この条件分岐で日曜始まりを月曜始まりに変える
if wday == 0
  monday_wday = 6
else
  monday_wday = wday - 1
end

# iはループの判定に利用。実際に日数の出力時に+1加算して利用する
i = 1 
# dは1~7までを一区切りとして改行の管理と1日の曜日まで空白を入れるために使います。# dはループの回数で+1加算
d = 1 
print "月 火 水 木 金 土 日\n"
while i <= last_day


  if d <= monday_wday
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

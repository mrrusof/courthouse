threads = []
10000.times do
  threads << Thread.new do
    i = 0
    nn = []
    while true
      nn << i += 1
    end
  end
end

threads.each { |t| t.join }

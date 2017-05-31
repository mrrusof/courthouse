#!/usr/bin/env ruby

$e = Hash.new

def e n
  if n == 0
    return ['']
  elsif $e.has_key? n
    return $e[n]
  end

  $e[n] = []
  i = 0
  j = n - 1
  while i < n
    e(i).each do |a|
      e(j).each do |b|
        $e[n] << "(#{a})#{b}"
      end
    end
    i += 1
    j -= 1
  end
  return $e[n]
end

while true
  n = readline.strip.to_i rescue break
  puts e n
end

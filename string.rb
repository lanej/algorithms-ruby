def String.reverse(string)
  i, j = 0, string.size - 1

  while i < j
    # swap
    tmp = string[i]
    string[i] = string[j]
    string[j] = tmp

    i, j = i + 1, j - 1
  end
end

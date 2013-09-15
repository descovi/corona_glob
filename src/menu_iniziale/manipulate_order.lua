function manipulate_order_invert_group(original_table, new_table)
  new_table[1]  = original_table[6]
  new_table[2]  = original_table[7]
  new_table[3]  = original_table[8]
  new_table[4]  = original_table[9]
  new_table[5]  = original_table[10]
  new_table[6]  = original_table[1]
  new_table[7]  = original_table[2]
  new_table[8]  = original_table[3]
  new_table[9]  = original_table[4]
  new_table[10] = original_table[5]
end
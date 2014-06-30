def hash_to_array(hash, lines = '')
  hash.each do |name, value|
    lines << case value
             when Hash
               "'#{name}' => array(#{hash_to_array(value, lines)}),"
             when Array
               "array('#{value.join("','")}')"
             else
               "'#{name}' => '#{value}',"
             end
  end
end

class Encryption_Engine {
  int current_stage = 0;
  String instructional_message = "Type the message to be encrypted and press ENTER.";
  String delimiter = ",";

  String unencrypted_plaintext = "";
  int[] unencrypted_ascii;
  String[] unencrypted_binary;

  String key_plaintext = "";
  int[] key_ascii;
  String[] key_binary;

  String[] encrypted_binary;
  int[] encrypted_ascii;
  String encrypted_plaintext = "";

  String[] decrypted_binary;
  int[] decrypted_ascii;
  String decrypted_plaintext = "";

  void advance_to_next_stage() {
    if (current_stage == 0) {
      set_unencrypted_message(last_stored_input);
      instructional_message = "Type an encryption key and press enter.";
    } else if (current_stage == 1) {
      set_encryption_key(last_stored_input);
      encrypt_data();
      attempt_to_decrypt_data_with_key(key_plaintext);
      instructional_message = "Press ENTER to continue.";
    } else if (current_stage == 4) {
      instructional_message = "Press ENTER to restart.";
    } else if (current_stage > 5) {
      reset_activity();
    }
    current_stage = (current_stage + 1) % 7;
  }

  void set_unencrypted_message(String message) {
    unencrypted_plaintext = message;
    unencrypted_ascii = string_to_ascii(unencrypted_plaintext);
    unencrypted_binary = ascii_to_binary(unencrypted_ascii);
  }

  void set_encryption_key(String input_key) {
    key_plaintext = input_key;
    key_ascii = string_to_ascii(key_plaintext);
    key_binary = ascii_to_binary(key_ascii);
  }

  void encrypt_data() {
    encrypted_binary = bitwise_binary_addition(unencrypted_binary, key_binary);
    encrypted_ascii = binary_to_ascii(encrypted_binary);
    encrypted_plaintext = ascii_to_string(encrypted_ascii);
  }

  boolean attempt_to_decrypt_data_with_key(String attempted_key) {
    decrypted_binary = bitwise_binary_addition(encrypted_binary, ascii_to_binary(string_to_ascii(attempted_key)));
    decrypted_ascii = binary_to_ascii(decrypted_binary);
    decrypted_plaintext = ascii_to_string(decrypted_ascii);
    return decrypted_plaintext == unencrypted_plaintext;
  }

  int[] string_to_ascii(String input) {
    int[] ascii_numbers= new int[input.length()];
    for (int i = 0; i < input.length(); i++) {
      ascii_numbers[i] = int(input.charAt(i));
    }
    return ascii_numbers;
  }

  String ascii_to_string(int[] ascii_numbers) {
    String output = "";
    for (int i = 0; i < ascii_numbers.length; i++) {
      if (ascii_numbers[i] > 31 && ascii_numbers[i] < 127) output += (char)ascii_numbers[i];
      else output += "*";
    }
    return output;
  }

  String[] ascii_to_binary(int[] ascii_numbers) {
    String[] binary_bytes = new String[ascii_numbers.length];
    for (int i = 0; i < ascii_numbers.length; i++) {
      binary_bytes[i] = Integer.toBinaryString(ascii_numbers[i]);
      while (binary_bytes[i].length() < 8) {
        binary_bytes[i] = "0" + binary_bytes[i];
      }
    }
    return binary_bytes;
  }

  int[] binary_to_ascii(String[] binary_bytes) {
    int[] ascii_numbers = new int[binary_bytes.length];
    for (int i = 0; i < binary_bytes.length; i++) {
      ascii_numbers[i] = Integer.parseInt(binary_bytes[i], 2);
    }
    return ascii_numbers;
  }

  String[] bitwise_binary_addition(String[] top, String[] bottom) {
    String[] return_bytes = new String[top.length];
    char top_digit;
    char bottom_digit;
    for (int i = 0; i < top.length; i++) {
      return_bytes[i] = "";
      for (int j = 0; j < top[i].length(); j++) {
        top_digit = top[i].charAt(j);
        bottom_digit = bottom[i % bottom.length].charAt(j);
        if (bottom_digit == '0') return_bytes[i] += top_digit;
        else if (top_digit == '1') return_bytes[i] += '0';
        else return_bytes[i] += '1';
      }
    }
    return return_bytes;
  }

  String array_to_nice_string(String[] array) {
    String nice_string = "";
    for (int i = 0; i < array.length; i++) {
      if (i > 0) nice_string += " ";
      nice_string += array[i];
    }
    return nice_string;
  }

  String array_to_nice_string(int[] array) {
    String[] strings_from_numbers = new String[array.length];
    for (int i = 0; i < array.length; i++) {
      strings_from_numbers[i] = "" + array[i];
    }
    return array_to_nice_string(strings_from_numbers);
  }

  void reset_activity() {
    instructional_message = "Type the message to be encrypted and press ENTER.";

    unencrypted_plaintext = "";
    key_plaintext = "";
    encrypted_plaintext = "";
    decrypted_plaintext = "";
  }
  
  String generate_random_encryption_key_of_length(int len){
    String random_key = "";
    for(int i =0; i < len; i++){
      random_key += (char)floor(random(32, 127));
    }
    return random_key;
  }
}

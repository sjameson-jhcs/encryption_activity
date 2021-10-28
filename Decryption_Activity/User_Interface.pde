class User_Interface {
  int left_indent = 50;
  int top_indent = 20;
  int line_spacing = 20;

  void draw_all_elements(int current_stage, String instructional_message) {
    text("NOTICE: " + instructional_message, left_indent, top_indent + line_spacing);
    if (current_stage < 2) {
      text("INPUT: " + running_input_characters, left_indent, top_indent + 2*line_spacing);
    }
    if (current_stage > 0) {
      text("Plaintext Message: " + main_engine.unencrypted_plaintext, left_indent, top_indent + 4*line_spacing);
      text("ASCII Message: " + main_engine.array_to_nice_string(main_engine.unencrypted_ascii), left_indent, top_indent + 5*line_spacing);
      text("Binary Message: " + main_engine.array_to_nice_string(main_engine.unencrypted_binary), left_indent, top_indent + 6*line_spacing);
    }
    if (current_stage > 1) {
      text("Plaintext Encryption Key: " + main_engine.key_plaintext, left_indent, top_indent + 8*line_spacing);
      text("ASCII Encryption Key: " + main_engine.array_to_nice_string(main_engine.key_ascii), left_indent, top_indent + 9*line_spacing);
      text("Binary Encryption Key: " + main_engine.array_to_nice_string(main_engine.key_binary), left_indent, top_indent + 10*line_spacing);
    }
    if (current_stage > 2) {
      text(main_engine.array_to_nice_string(main_engine.unencrypted_binary), left_indent, top_indent + 12*line_spacing);
      text(main_engine.array_to_nice_string(main_engine.key_binary), left_indent, top_indent + 13*line_spacing);
      text("+", left_indent * 0.8, top_indent + 12.5*line_spacing);
      line(left_indent, top_indent + 13.5*line_spacing, width-left_indent, top_indent + 13.5*line_spacing);
      text(main_engine.array_to_nice_string(main_engine.encrypted_binary), left_indent, top_indent + 14.5*line_spacing);
    }
    if (current_stage > 3) {
      text("Binary Encrypted Message: " + main_engine.array_to_nice_string(main_engine.encrypted_binary), left_indent, top_indent + 16*line_spacing);
      text("ASCII Encrypted Message: " + main_engine.array_to_nice_string(main_engine.encrypted_ascii), left_indent, top_indent + 17*line_spacing);
      text("Plaintext Encrypted Message: " + main_engine.encrypted_plaintext, left_indent, top_indent + 18*line_spacing);
    }
    if (current_stage > 4) {
      text(main_engine.array_to_nice_string(main_engine.encrypted_binary), left_indent, top_indent + 20*line_spacing);
      text(main_engine.array_to_nice_string(main_engine.key_binary), left_indent, top_indent + 21*line_spacing);
      text("+", left_indent * 0.8, top_indent + 20.5*line_spacing);
      line(left_indent, top_indent + 21.5*line_spacing, width-left_indent, top_indent + 21.5*line_spacing);
      text(main_engine.array_to_nice_string(main_engine.decrypted_binary), left_indent, top_indent + 22.5*line_spacing);
    }
    if (current_stage > 5) {
      text("Binary Decrypted Message: " + main_engine.array_to_nice_string(main_engine.decrypted_binary), left_indent, top_indent + 24*line_spacing);
      text("ASCII Decrypted Message: " + main_engine.array_to_nice_string(main_engine.decrypted_ascii), left_indent, top_indent + 25*line_spacing);
      text("Plaintext Decrypted Message: " + main_engine.decrypted_plaintext, left_indent, top_indent + 26*line_spacing);
    }
  }
}

String running_input_characters = "";
String last_stored_input = "";
void keyPressed() {
  if (keyCode == ENTER && (running_input_characters.length() > 0 || main_engine.current_stage > 1)) {
    last_stored_input = running_input_characters;
    running_input_characters = "";
    main_engine.advance_to_next_stage();
  } else {
    if (keyCode > 31 && keyCode < 127 && key != main_engine.delimiter.charAt(0)) {
      running_input_characters += key;
    }
  }
}

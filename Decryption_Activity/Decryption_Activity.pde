Encryption_Engine main_engine;
User_Interface ui;

void setup() {
  size(1000, 600);
  fill(0, 255, 0);
  stroke(0, 255, 0);
  PFont customFont = loadFont("Courier-14.vlw");
  textFont(customFont);

  main_engine = new Encryption_Engine();
  ui = new User_Interface();
  
  // **************************************************** CHALLENGE START ****************************************************
  // Given the example below. Attempt to brute force crack a randomly generated encryption key.
  // You must crack the key using brute force. Accessing the key directly defeats the purpose of the challenge.
  // You may only edit code between the *** CHALLENGE START and END *** lines
  // Once you crack a 6 character key, try increasing the length of the key. How long of a key is your computer able to crack?
  
  main_engine.set_unencrypted_message("This message will be encrypted.");
  String random_key = main_engine.generate_random_encryption_key_of_length(6);
  main_engine.set_encryption_key(random_key);
  main_engine.encrypt_data();
  String attempted_key = "abc123ABC!@#";
  if(main_engine.attempt_to_decrypt_data_with_key(attempted_key)){
    println("The encryption key was discovered to be: " + attempted_key);
  }
  else{
    println("The encryption key is not: " + attempted_key);
  }
  
  // **************************************************** CHALLENGE END ****************************************************
}


void draw() {
  background(0);
  ui.draw_all_elements(main_engine.current_stage, main_engine.instructional_message);
}

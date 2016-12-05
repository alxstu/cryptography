#!/usr/bin/env xcrun swift
import Foundation

//simple array to hold the alphabet
var abc: [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

//function to encrypt and decrypt text. takes a "de" pr "en" string to set de- or encrypt
func vigenereCipher(crypt: String, textInput: String, keyInput: String) -> String{

		//text array stores single lowercased characters
		let text = [Character](textInput.lowercased().characters)
		//key array stores single lowercased characters
		let key = [Character](keyInput.lowercased().characters)
		//output variable to return a string
		var outputText = ""		
		//iteration counter for the key
		var keyCounter = 0
		//error text for wrong keywords
		var errorText = "CHECK KEY"			

	//iterates through the text array 
	for i in 0...text.count-1{
			//switch between encrypt and decrypt
		switch crypt {
			//en for encryption
			case "en":
			//adds a whitespace between 5 character blocks (every 6. position)
				if outputText.characters.count % 6 == 0 && i < text.count{
					outputText.append(" ")
				}
					//optional unbinding to make sure that there is a value and not nil
					if let _textIndex = abc.index(of: text[i]){
						if let _keyIndex = abc.index(of: key[keyCounter]){

							//this new index to take the character from the array is calculated by adding the keyword index with the textindex
							var newIndex = _textIndex + _keyIndex
						
							//if the new index is not bigger than the alphabet, add character to the output text  
							if newIndex < abc.count{
								outputText.append(abc[newIndex])
							}
							//else subtract the quantity of characters of the alphabet and add the character to the output text
							else {
								outputText.append(abc[newIndex-abc.count])	
							}									
							//loop the keyword...  set to 0 if the end of the keyword is reached else count 1 up
							if keyCounter == key.count-1 { keyCounter = 0 
							}
							else {
								keyCounter = keyCounter + 1
							}
						} 
						//if the abc.index(of: key[keyCounter]) throws nil, the keyword is wrong
						else { 
							outputText = errorText
						}
					}
			//de for decryption
			case "de":
					//optional unbinding to make sure that there is a value and not nil
					if let _textIndex = abc.index(of: text[i]){
						if let _keyIndex = abc.index(of: key[keyCounter]){

							//this new index to take the character from the array is calculated by subtracting the keyword index from the textindex
							var newIndex = _textIndex - _keyIndex
							
							//if the new index is not bigger than the alphabet and not smaler than 0, add character to the output text
							if newIndex < abc.count && newIndex >= 0{
								outputText.append(abc[newIndex])
							}
							//else add the quantity of characters of the alphabet and add the character to the output text
							else {
								outputText.append(abc[newIndex+abc.count])	
							}
							
							//loop the keyword...  set to 0 if the end of the keyword is reached else count 1 up
							if keyCounter == key.count-1 { 
								keyCounter = 0 
							}
							else{
								keyCounter = keyCounter + 1
							}
						}
						//if the abc.index(of: key[keyCounter]) throws nil, the keyword is wrong
						else{
							outputText = errorText
						}
					}
			default:
			break;
		}
	}
		
		//add random characters the end of the output text to guarantee full 5 character blocks
		if crypt == "en" && outputText != errorText {
		//this deletes the first character from the output text, it's whitespace
		outputText.remove(at: outputText.startIndex)
		//we have to subtract the added whitespace from our calculation
		if (((outputText.characters.count-(outputText.characters.count/6))) % 5 != 0) {
		//add a random character to the end till it's a completed 5 character block
		while ((outputText.characters.count-(outputText.characters.count/6)) % 5) != 0{
		//arc4random()%26 throws a number between 0 and 25
		outputText.append(abc[(Int(arc4random()%26))])
		}
	}
	}

	return outputText
}
print(vigenereCipher(crypt: "en", textInput: "the medium is the message", keyInput: "mcluhan"))
print(vigenereCipher(crypt: "de", textInput: "fjpgl dvgot mahry gdmhg rzuhh", keyInput: "mcluhan"))

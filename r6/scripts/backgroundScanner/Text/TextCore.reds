/*
* Core text definitions and scanner labels
*
* Usage:
* Each string requires at minimum a female-variant to be defined. 
* If the string is not gender-neutral both a male and female string should be defined seperately.
*
* Tokens:
* Text strings support token replacement, which will be replaced by a randomized value in the character generation process. 
* Ex. Hired by the %corp% Corporation out of college.
*
* The available tokens are as follows: 
* %corp% - Picks a random corporation to insert into the string
* %eddies% - Picks a random dollar amount to insert into the string
* %year% - Picks a random year (date) to insert into the string
* %years% - Picks a random amount of years to insert into the string
* %young_age% - Picks a random age within childhood/teenage years
*/
public abstract class TextCore {
    // Static Scanner Texts
    public static func SCANNER_BACKGROUND() -> String { return "Background"; }
    public static func SCANNER_CHILDHOOD() -> String { return "Early Life"; }
    public static func SCANNER_SIG_EVENTS() -> String { return "Significant Events"; }
    public static func SCANNER_FOOTER() -> String { return "© InfoComp 2077. All rights reserved."; }
}

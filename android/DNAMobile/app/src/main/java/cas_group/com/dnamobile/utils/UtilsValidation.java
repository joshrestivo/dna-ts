package cas_group.com.dnamobile.utils;

public class UtilsValidation {



    public static boolean isValidEmail(String input) {
        if (!isNullOrEmpty(input)) {
            return android.util.Patterns.EMAIL_ADDRESS.matcher(input).matches();
        }
        return false;
    }
    public static boolean isNullOrEmpty(String input) {
        if (input == null) {
            return true;
        }

        String trimmedInput = input.trim();
        return "".equalsIgnoreCase(trimmedInput) || "null".equalsIgnoreCase(trimmedInput);
    }

    public static boolean isNotNullOrWhitespace(String input) {
        return !isNullOrEmpty(input);
    }
}

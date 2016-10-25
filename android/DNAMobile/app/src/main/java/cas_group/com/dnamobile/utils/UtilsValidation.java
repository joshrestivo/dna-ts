package cas_group.com.dnamobile.utils;

public class UtilsValidation {

    public static boolean isNullOrEmpty(String input) {
        return input == null || "".equalsIgnoreCase(input);
    }

    public static boolean isValidEmail(String input) {
        if (!isNullOrEmpty(input)) {
            return android.util.Patterns.EMAIL_ADDRESS.matcher(input).matches();
        }
        return false;
    }
}

package cas_group.com.dnamobile.utils;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import cas_group.com.dnamobile.R;


public class AlertDialogManager {

    private static AlertDialog _alertDialog;

    public static void showErrorDialog(Context context, String message) {
        if (context == null){
            return;
        }
        if (_alertDialog != null) {
            _alertDialog = null;
        }
        if(!((Activity) context).isFinishing())
        {
            _alertDialog = new AlertDialog.Builder(context).create();
            _alertDialog.setTitle(context.getString(R.string.error));
            _alertDialog.setMessage(message);
            _alertDialog.setButton(DialogInterface.BUTTON_POSITIVE, context.getString(R.string.ok),
                    new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            _alertDialog.dismiss();
                        }
                    });

            _alertDialog.show();
        }

    }
    public static void showDialogWithCallBack(Context context, String title, String message,final DialogCallback callback){
        if (_alertDialog != null) {
            _alertDialog.dismiss();
        }
        if(!((Activity) context).isFinishing()) {
            _alertDialog = new AlertDialog.Builder(context).create();
            _alertDialog.setTitle(title);
            _alertDialog.setMessage(message);
            _alertDialog.setButton(DialogInterface.BUTTON_POSITIVE, context.getString(R.string.ok),
                    new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            _alertDialog.dismiss();
                            callback.yes();
                        }
                    });

            _alertDialog.show();
        }

    }
    public static void showErrorDialogWithCallBack(Context context, String message,final DialogCallback callback){
        AlertDialogManager.showDialogWithCallBack(context,context.getString(R.string.error), message, callback);
//        if (_alertDialog != null) {
//            _alertDialog.dismiss();
//        }
//        if(!((Activity) context).isFinishing()) {
//            _alertDialog = new AlertDialog.Builder(context).create();
//            _alertDialog.setTitle(context.getString(R.string.error));
//            _alertDialog.setMessage(message);
//            _alertDialog.setButton(DialogInterface.BUTTON_POSITIVE, context.getString(R.string.ok),
//                    new DialogInterface.OnClickListener() {
//                        public void onClick(DialogInterface dialog, int which) {
//                            _alertDialog.dismiss();
//                            callback.yes();
//                        }
//                    });
//
//            _alertDialog.show();
//        }

    }

    public static void showGeneralErrorDialog(Context context) {
        if (context != null){
            showErrorDialog(context, context.getString(R.string.general_error_message));
        }

    }

    public static void showInfoDialog(Context context, String message) {
        final AlertDialog alertDialog = new AlertDialog.Builder(context).create();
        alertDialog.setMessage(message);
        alertDialog.setButton(DialogInterface.BUTTON_POSITIVE, context.getString(R.string.ok),
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        alertDialog.dismiss();
                    }
                });

        alertDialog.show();
    }

    public static void showConfirmDialog(Context context, String title, String message, String yesCaption, String noCaption, final DialogCallback callback) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle(title);
        builder.setMessage(message);
        if (UtilsValidation.isNullOrEmpty(yesCaption)) {
            yesCaption = context.getString(R.string.yes);
        }

        if (UtilsValidation.isNullOrEmpty(noCaption)) {
            noCaption = context.getString(R.string.no);
        }

        builder.setPositiveButton(yesCaption, new Dialog.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                callback.yes();
            }
        });

        builder.setNegativeButton(noCaption, new Dialog.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                callback.no();
            }
        });

        builder.show();
    }

    public static void showOneInputDialog(final Context context, String title, String message, int keyboardInputType,
                                          final String validationPattern, final String invalidDataMessage,
                                          String yesCaption, String noCaption,
                                          final DialogCallback callback) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        if (title != null) {
            builder.setTitle(title);
        }

        if (message != null) {
            builder.setMessage(message);
        }

        final EditText input = new EditText(context);
        input.setInputType(keyboardInputType);
        builder.setView(input);
        if (yesCaption == null) {
            yesCaption = context.getString(R.string.cancel);
        }

        builder.setPositiveButton(yesCaption, null);

        if (noCaption == null) {
            noCaption = context.getString(R.string.cancel);
        }

        builder.setNegativeButton(noCaption, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                callback.no();
            }
        });

        final AlertDialog dialog = builder.create();
        dialog.show();
        dialog.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                String value = input.getText().toString();
                if (value != null && !value.equalsIgnoreCase("")) {
                    if (!"".equalsIgnoreCase(validationPattern) && validationPattern != null) {
                        if (!value.matches(validationPattern)) {
                            Toast.makeText(context, invalidDataMessage, Toast.LENGTH_SHORT).show();
                            return;
                        }
                    }

                    dialog.dismiss();
                    callback.yes(value);
                }
            }
        });
    }
}
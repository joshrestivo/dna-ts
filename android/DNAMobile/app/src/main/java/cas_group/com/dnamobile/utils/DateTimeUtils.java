package cas_group.com.dnamobile.utils;

import android.content.Context;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import cas_group.com.dnamobile.R;

/**
 * Created by kuccu on 1/15/15.
 */
public class DateTimeUtils {

    /*
 * Copyright 2012 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

    private static final int SECOND_MILLIS = 1000;
    private static final int MINUTE_MILLIS = 60 * SECOND_MILLIS;
    private static final int HOUR_MILLIS = 60 * MINUTE_MILLIS;
    private static final int DAY_MILLIS = 24 * HOUR_MILLIS;
    public static String stringFromUTCString(String utcString){
        Date utcDate = dateFromUTCString(utcString);
        return stringFromUTCDate(utcDate);

    }
    public static String stringFromUTCDate(Date date){
        String format = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setTimeZone(TimeZone.getDefault());
        if(date != null){
           return sdf.format(date);
        }
        return "";
    }
    public static String stringFromUTCDateShortDate(Date date){
        String format = "dd/MM/yyy HH:mm";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setTimeZone(TimeZone.getDefault());
        if(date != null){
            return sdf.format(date);
        }
        return "";
    }
    public static Date dateFromUTCString(String utcString){
        DateFormat m_ISO8601UTC = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

        final TimeZone utc = TimeZone.getTimeZone("UTC");
        m_ISO8601UTC.setTimeZone(utc);
        try {
            return m_ISO8601UTC.parse(utcString);
        } catch (ParseException e) {
            e.printStackTrace();
            return  null;
        }
//        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
    }
    public static  int compareTwoDateFromString(String str1, String str2){
        Date date1 = DateTimeUtils.dateFromUTCString(str1);
        Date date2 = DateTimeUtils.dateFromUTCString(str2);
        return date2.compareTo(date1);
    }
    public static  String getTimeAgoFromString(String stringTime, Context ctx){
        return DateTimeUtils.getTimeAgo(DateTimeUtils.dateFromUTCString(stringTime),ctx);
    }
    public static String getTimeAgo(Date dateTime, Context ctx) {
        long time = dateTime.getTime();
        if (time < 1000000000000L) {
            // if timestamp given in seconds, convert to millis
            time *= 1000;
        }

        Calendar calendar = Calendar.getInstance();
        Date currentDate = calendar.getTime();
        long now = currentDate.getTime();
        if (time <= 0) {
            return null;
        }

        // TODO: localize
        final long diff = now - time;
        if (diff < MINUTE_MILLIS) {
            return ctx.getString(R.string.just_now);
        } else if (diff < 2 * MINUTE_MILLIS) {
            return ctx.getString(R.string.minnu_ago);
        } else if (diff < 50 * MINUTE_MILLIS) {
            return  ctx.getString(R.string.minnus_ago,diff / MINUTE_MILLIS);
        } else if (diff < 90 * MINUTE_MILLIS) {
            return ctx.getString(R.string.hour_ago);
        } else if (diff < 24 * HOUR_MILLIS) {
            return ctx.getString(R.string.hours_ago,diff / HOUR_MILLIS);
        } else if (diff < 48 * HOUR_MILLIS) {
            return ctx.getString(R.string.yesterday);
        } else {
            return ctx.getString(R.string.day_ago,diff / DAY_MILLIS
            );
        }
    }

    public static int getDiffYears(Date first, Date last) {
        Calendar a = getCalendar(first);
        Calendar b = getCalendar(last);
        int diff = b.get(Calendar.YEAR) - a.get(Calendar.YEAR);
        if (a.get(Calendar.MONTH) > b.get(Calendar.MONTH) ||
                (a.get(Calendar.MONTH) == b.get(Calendar.MONTH) && a.get(Calendar.DATE) > b.get(Calendar.DATE))) {
            diff--;
        }
        return diff;
    }

    public static Calendar getCalendar(Date date) {
        Calendar cal = Calendar.getInstance(Locale.US);
        cal.setTime(date);
        return cal;
    }
}

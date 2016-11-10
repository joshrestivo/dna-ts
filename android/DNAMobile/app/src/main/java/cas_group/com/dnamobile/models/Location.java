package cas_group.com.dnamobile.models;

import com.google.android.gms.maps.model.LatLng;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by kuccu on 11/6/16.
 */

public class Location extends BaseModel{
    public int getIdLoc() {
        return _idLoc;
    }

    public void setIdLoc(int idLoc) {
        _idLoc = idLoc;
    }

    public String getNameLoc() {
        return _nameLoc;
    }

    public void setNameLoc(String nameLoc) {
        _nameLoc = nameLoc;
    }

    public String getCity() {
        return _city;
    }

    public void setCity(String city) {
        _city = city;
    }

    public String getState() {
        return _state;
    }

    public void setState(String state) {
        _state = state;
    }

    public String getCountryCode() {
        return _countryCode;
    }

    public void setCountryCode(String countryCode) {
        _countryCode = countryCode;
    }

    public String getCountry() {
        return _country;
    }

    public void setCountry(String country) {
        _country = country;
    }

    public String getStreetAlertsRssFeedUrl() {
        return _streetAlertsRssFeedUrl;
    }

    public void setStreetAlertsRssFeedUrl(String streetAlertsRssFeedUrl) {
        _streetAlertsRssFeedUrl = streetAlertsRssFeedUrl;
    }

    public String getNewRssUrl1() {
        return _newRssUrl1;
    }

    public void setNewRssUrl1(String newRssUrl1) {
        _newRssUrl1 = newRssUrl1;
    }

    public String getNewRssUrl2() {
        return _newRssUrl2;
    }

    public void setNewRssUrl2(String newRssUrl2) {
        _newRssUrl2 = newRssUrl2;
    }

    public String getNewRssUrl3() {
        return _newRssUrl3;
    }

    public void setNewRssUrl3(String newRssUrl3) {
        _newRssUrl3 = newRssUrl3;
    }

    public String getGoogleCalendarId() {
        return _googleCalendarId;
    }

    public void setGoogleCalendarId(String googleCalendarId) {
        _googleCalendarId = googleCalendarId;
    }

    public String getGoogleCalendarApiKey() {
        return _googleCalendarApiKey;
    }

    public void setGoogleCalendarApiKey(String googleCalendarApiKey) {
        _googleCalendarApiKey = googleCalendarApiKey;
    }

    public boolean isHasCommingEvents() {
        return _hasCommingEvents;
    }

    public void setHasCommingEvents(boolean hasCommingEvents) {
        _hasCommingEvents = hasCommingEvents;
    }

    public boolean isHasRequestService() {
        return _hasRequestService;
    }

    public void setHasRequestService(boolean hasRequestService) {
        _hasRequestService = hasRequestService;
    }

    public boolean isHasLocationInfo() {
        return _hasLocationInfo;
    }

    public void setHasLocationInfo(boolean hasLocationInfo) {
        _hasLocationInfo = hasLocationInfo;
    }

    public boolean isHasStreetAlerts() {
        return _hasStreetAlerts;
    }

    public void setHasStreetAlerts(boolean hasStreetAlerts) {
        _hasStreetAlerts = hasStreetAlerts;
    }

    public String getCreatedBy() {
        return _createdBy;
    }

    public void setCreatedBy(String createdBy) {
        _createdBy = createdBy;
    }

    public String getUpdatedBy() {
        return _updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        _updatedBy = updatedBy;
    }

    public String getCreatedAt() {
        return _createdAt;
    }

    public void setCreatedAt(String createdAt) {
        _createdAt = createdAt;
    }

    public String getUpdateAt() {
        return _updateAt;
    }

    public void setUpdateAt(String updateAt) {
        _updateAt = updateAt;
    }

    public int getClientResourceId() {
        return _clientResourceId;
    }

    public void setClientResourceId(int clientResourceId) {
        _clientResourceId = clientResourceId;
    }

    public String getClientResourceName() {
        return _clientResourceName;
    }

    public void setClientResourceName(String clientResourceName) {
        _clientResourceName = clientResourceName;
    }

    public ClientResource getClientResource() {
        return _clientResource;
    }

    public void setClientResource(ClientResource clientResource) {
        _clientResource = clientResource;
    }


    public Location(JSONObject jsonObject) {

        _idLoc = jsonObject.optInt("id");

        double latitude = jsonObject.optDouble("latitude");
        double longitude = jsonObject.optDouble("longitude");
        _position = new LatLng(latitude, longitude);

        _nameLoc = jsonObject.optString("name");
        _city = jsonObject.optString("city");
        _state = jsonObject.optString("state");
        _countryCode = jsonObject.optString("country_code");
        _country = jsonObject.optString("country");
        _streetAlertsRssFeedUrl = jsonObject.optString("street_alerts_rss_feed_url");
        _newRssUrl1 = jsonObject.optString("news_rss_url_1");
        _newRssUrl2 = jsonObject.optString("news_rss_url_2");
        _newRssUrl3 = jsonObject.optString("news_rss_url_3");
        _googleCalendarId = jsonObject.optString("google_calendar_id");
        _googleCalendarApiKey = jsonObject.optString("google_calendar_api_key");

        _hasCommingEvents = jsonObject.optBoolean("has_upcomming_events");
        _hasRequestService = jsonObject.optBoolean("has_request_service");
        _hasLocationInfo = jsonObject.optBoolean("has_location_info");
        _hasStreetAlerts = jsonObject.optBoolean("has_street_alerts");

        _createdBy = jsonObject.optString("created_by");
        _updatedBy = jsonObject.optString("updated_by");
        _createdAt = jsonObject.optString("created_at");
        _updateAt = jsonObject.optString("updated_at");

        _clientResourceId = jsonObject.optInt("client_resource_id");
        _clientResourceName = jsonObject.optString("client_resource_name");

        try {
            JSONObject jsonObject1 = jsonObject.getJSONObject("client_resource");
            _clientResource = new ClientResource(jsonObject1);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public LatLng getPosition() {
        return _position;
    }

    public void setPosition(LatLng position) {
        _position = null;
        if (position != null) {
            _position = new LatLng(position.latitude, position.longitude);
        }
    }

    public double getPositionLatitude() {
        return _position == null ? 0 : _position.latitude;
    }

    public double getPositionLongitude() {
        return _position == null ? 0 : _position.longitude;
    }



    private int _idLoc;
    private LatLng _position;
    private String _nameLoc;
    private String _city;
    private String _state;
    private String _countryCode;
    private String _country;
    private String _streetAlertsRssFeedUrl;
    private String _newRssUrl1;
    private String _newRssUrl2;
    private String _newRssUrl3;
    private String _googleCalendarId;
    private String _googleCalendarApiKey;

    private boolean _hasCommingEvents;
    private boolean _hasRequestService;
    private boolean _hasLocationInfo;
    private boolean _hasStreetAlerts;

    private String _createdBy;
    private String _updatedBy;
    private String _createdAt;
    private String _updateAt;

    private int _clientResourceId;
    private String _clientResourceName;

    private ClientResource _clientResource;


}

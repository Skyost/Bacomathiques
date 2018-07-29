package fr.bacomathiques.lesson;

import android.net.Uri;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import fr.bacomathiques.util.Utils;

/**
 * Represents a lesson and its content.
 */

public class LessonContent {

	/**
	 * The lesson's ID.
	 */

	private String id;

	/**
	 * The lesson's title.
	 */

	private String title;

	/**
	 * The lesson's content.
	 */

	private String content;

	/**
	 * The lesson's URL.
	 */

	private String url;

	/**
	 * All available annals.
	 */

	private List<String> annals = new ArrayList<>();

	/**
	 * Creates a new lesson content instance.
	 *
	 * @param object The JSON object.
	 * @param url The lesson's URL.
	 *
	 * @throws JSONException If a JSON exception occurs.
	 */

	public LessonContent(final JSONObject object, final String url) throws JSONException {
		this(object.getString("id"), object.getString("title"), Utils.fromHtml(object.getString("content")).toString(), url, object.has("annals") ? object.getJSONArray("annals") : null);
	}

	/**
	 * Creates a new lesson content instance.
	 *
	 * @param id The lesson's ID.
	 * @param title The lesson's title.
	 * @param content The lesson's content.
	 * @param url The lesson's URL.
	 * @param annals All annals.
	 *
	 * @throws JSONException If a JSON exception occurs.
	 */

	private LessonContent(final String id, final String title, final String content, final String url, final JSONArray annals) throws JSONException {
		this.id = id;
		this.title = title;
		this.content = content;
		this.url = url;
		if(annals == null) {
			return;
		}

		for(int i = 0; i < annals.length(); i++) {
			this.annals.add(annals.getString(i));
		}
	}

	/**
	 * Returns the lesson ID.
	 *
	 * @return The lesson ID.
	 */

	public final String getId() {
		return id;
	}

	/**
	 * Sets the lesson ID.
	 *
	 * @param id The lesson ID.
	 */

	public final void setId(final String id) {
		this.id = id;
	}

	/**
	 * Returns the lesson title.
	 *
	 * @return The lesson title.
	 */

	public final String getTitle() {
		return title;
	}

	/**
	 * Sets the lesson title.
	 *
	 * @param title The lesson title.
	 */

	public final void setTitle(final String title) {
		this.title = title;
	}

	/**
	 * Returns the lesson content.
	 *
	 * @return The lesson content.
	 */

	public final String getContent() {
		return content;
	}

	/**
	 * Sets the lesson content.
	 *
	 * @param content The lesson content.
	 */

	public final void setContent(final String content) {
		this.content = content;
	}

	/**
	 * Returns the lesson url.
	 *
	 * @return The lesson url.
	 */

	public final String getUrl() {
		return url;
	}

	/**
	 * Sets the lesson url.
	 *
	 * @param url The lesson url.
	 */

	public final void setUrl(final String url) {
		this.url = url;
	}

	/**
	 * Returns the lesson PDF url.
	 *
	 * @return The lesson PDF url.
	 */

	public final Uri getPDFUrl() {
		return Uri.parse(LessonSummary.BASE_URL + "assets/pdf/lessons/" + Uri.encode(title.replace('é', 'e').replace('É', 'E')) + ".pdf");
	}

	/**
	 * Returns all available annals.
	 *
	 * @return All available annals.
	 */

	public final List<String> getAnnals() {
		return annals;
	}

}

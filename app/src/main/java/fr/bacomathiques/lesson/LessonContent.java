package fr.bacomathiques.lesson;

import android.net.Uri;

import org.json.JSONException;
import org.json.JSONObject;

import fr.bacomathiques.utils.Utils;

public class LessonContent {

	private String id;
	private String title;
	private String content;
	private String url;

	public LessonContent(final JSONObject object, final String url) throws JSONException {
		this(object.getString("id"), object.getString("title"), Utils.fromHtml(object.getString("content")).toString(), url);
	}

	public LessonContent(final String id, final String title, final String content, final String url) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.url = url;
	}

	/**
	 * Gets the lesson ID.
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
	 * Gets the lesson title.
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
	 * Gets the lesson content.
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
	 * Gets the lesson url.
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
	 * Gets the lesson PDF url.
	 *
	 * @return The lesson PDF url.
	 */

	public final Uri getPDFUrl() {
		return Uri.parse(LessonSummary.BASE_URL + "assets/pdf/lessons/" + Uri.encode(title.replace('é', 'e').replace('É', 'E')) + ".pdf");
	}

}

package fr.bacomathiques.lesson;

import android.os.Parcel;
import android.os.Parcelable;

import org.json.JSONException;
import org.json.JSONObject;

import fr.bacomathiques.utils.Utils;

public class Lesson implements Parcelable {

	public static final String BASE_URL = "https://bacomathiqu.es/";
	public static final Parcelable.Creator<Lesson> CREATOR = new Parcelable.Creator<Lesson>() {

		@Override
		public final Lesson createFromParcel(final Parcel source) {
			return new Lesson(source);
		}

		@Override
		public final Lesson[] newArray(final int size) {
			return new Lesson[size];
		}

	};
	private static final String API_URL = BASE_URL + "api/v1/";
	private String id;
	private String title;
	private String description;
	private String preview;
	private String placeholder;

	private Lesson(final Parcel parcel) {
		this(parcel.readString(), parcel.readString(), parcel.readString(), parcel.readString(), parcel.readString());
	}

	public Lesson(final JSONObject object) throws JSONException {
		this(object.getString("id"), object.getString("title"), Utils.fromHtml(object.getString("excerpt")).toString(), object.getString("preview"), Utils.fromHtml(object.getString("caption")).toString());
	}

	public Lesson(final String id, final String title, final String description, final String preview, final String placeholder) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.preview = preview;
		this.placeholder = placeholder;
	}

	/**
	 * Gets lessons URL.
	 *
	 * @return Lessons URL.
	 */

	public static String getLessonsURL() {
		return API_URL + "lessons.json";
	}

	@Override
	public final int describeContents() {
		return 0;
	}

	@Override
	public final void writeToParcel(final Parcel parcel, final int flags) {
		parcel.writeString(id);
		parcel.writeString(title);
		parcel.writeString(description);
		parcel.writeString(preview);
		parcel.writeString(placeholder);
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
	 * Gets the lesson description.
	 *
	 * @return The lesson description.
	 */

	public final String getDescription() {
		return description;
	}

	/**
	 * Sets the lesson description.
	 *
	 * @param description The lesson description.
	 */

	public final void setDescription(final String description) {
		this.description = description;
	}

	/**
	 * Sets the lesson preview.
	 *
	 * @return The lesson preview.
	 */

	public final String getPreview() {
		return preview;
	}

	/**
	 * Sets the lesson preview.
	 *
	 * @param preview The lesson preview.
	 */

	public final void setPreview(final String preview) {
		this.preview = preview;
	}

	/**
	 * Gets the lesson preview URL.
	 *
	 * @return The lesson preview URL.
	 */

	public final String getPreviewURL() {
		return BASE_URL + preview;
	}

	/**
	 * Gets the lesson placeholder.
	 *
	 * @return The lesson placeholder.
	 */

	public final String getPlaceholder() {
		return placeholder;
	}

	/**
	 * Sets the lesson placeholder.
	 *
	 * @param placeholder The lesson placeholder.
	 */

	public final void setPlaceholder(final String placeholder) {
		this.placeholder = placeholder;
	}

	/**
	 * Gets the lesson URL.
	 *
	 * @return The lesson URL.
	 */

	public final String getLessonURL() {
		return API_URL + "content/" + id + ".json";
	}

}

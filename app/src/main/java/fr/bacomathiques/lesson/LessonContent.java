package fr.bacomathiques.lesson;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;

import org.json.JSONException;
import org.json.JSONObject;

import fr.bacomathiques.utils.Utils;

public class LessonContent implements Parcelable {

	public static final Parcelable.Creator<LessonContent> CREATOR = new Parcelable.Creator<LessonContent>() {

		@Override
		public final LessonContent createFromParcel(final Parcel source) {
			return new LessonContent(source);
		}

		@Override
		public final LessonContent[] newArray(final int size) {
			return new LessonContent[size];
		}

	};

	private String id;
	private String title;
	private String content;

	private LessonContent(final Parcel parcel) {
		this(parcel.readString(), parcel.readString(), parcel.readString());
	}

	public LessonContent(final JSONObject object) throws JSONException {
		this(object.getString("id"), object.getString("title"), Utils.fromHtml(object.getString("content")).toString());
	}

	public LessonContent(final String id, final String title, final String content) {
		this.id = id;
		this.title = title;
		this.content = content;
	}

	@Override
	public final int describeContents() {
		return 0;
	}

	@Override
	public final void writeToParcel(final Parcel parcel, final int flags) {
		parcel.writeString(id);
		parcel.writeString(title);
		parcel.writeString(content);
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
	 * Gets the lesson PDF url.
	 *
	 * @return The lesson PDF url.
	 */

	public final Uri getPDFUrl() {
		return Uri.parse(Lesson.BASE_URL + "assets/pdf/lessons/" + Uri.encode(title.replace('é', 'e').replace('É', 'E')) + ".pdf");
	}

}

package fr.bacomathiques.adapters;

import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.RequestManager;
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions;
import com.bumptech.glide.request.RequestOptions;

import fr.bacomathiques.R;
import fr.bacomathiques.lesson.Lesson;
import fr.bacomathiques.utils.Utils;

public class LessonsAdapter extends RecyclerView.Adapter<LessonsAdapter.ViewHolder> {

	private static final RequestOptions DEFAULT_OPTIONS = new RequestOptions().centerCrop();

	private final RequestManager glide;
	private Lesson[] data;

	public LessonsAdapter(final RequestManager glide, final Lesson... data) {
		this.glide = glide;
		this.data = data == null ? new Lesson[0] : data;
	}

	/**
	 * Gets the adapter data.
	 *
	 * @return The adapter data.
	 */

	public final Lesson[] getData() {
		return data;
	}

	/**
	 * Sets the adapter data.
	 *
	 * @param data The adapter data.
	 */

	public final void setData(final Lesson... data) {
		this.data = data == null ? new Lesson[0] : data;
		notifyDataSetChanged();
	}

	@Override
	public final ViewHolder onCreateViewHolder(final ViewGroup parent, final int viewType) {
		final CardView view = (CardView)LayoutInflater.from(parent.getContext()).inflate(R.layout.main_lessons_recyclerview_item, parent, false);

		return new ViewHolder(view);
	}

	@Override
	public final void onBindViewHolder(final ViewHolder holder, final int position) {
		final Lesson lesson = data[position];

		glide.load(lesson.getPreviewURL()).apply(DEFAULT_OPTIONS).transition(DrawableTransitionOptions.withCrossFade()).into(holder.preview);
		holder.caption.setText(lesson.getPlaceholder());
		holder.caption.setAlpha(0f);
		holder.title.setText(lesson.getTitle());
		holder.description.setText(Utils.fromHtml(lesson.getDescription()));
		holder.checkOut.setTag(lesson.getLessonURL());
	}

	@Override
	public final int getItemCount() {
		return data.length;
	}

	static class ViewHolder extends RecyclerView.ViewHolder {

		private ImageView preview;
		private TextView caption;
		private TextView title;
		private TextView description;
		private TextView checkOut;

		private ViewHolder(final CardView view) {
			super(view);

			this.preview = view.findViewById(R.id.main_lessons_recyclerview_item_preview);
			this.caption = view.findViewById(R.id.main_lessons_recyclerview_item_caption);
			this.title = view.findViewById(R.id.main_lessons_recyclerview_item_title);
			this.description = view.findViewById(R.id.main_lessons_recyclerview_item_description);
			this.checkOut = view.findViewById(R.id.main_lessons_recyclerview_item_checkout);
		}

	}

}

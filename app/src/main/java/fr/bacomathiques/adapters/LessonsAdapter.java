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
import fr.bacomathiques.lesson.LessonSummary;
import fr.bacomathiques.utils.Utils;

public class LessonsAdapter extends RecyclerView.Adapter<LessonsAdapter.ViewHolder> {

	private static final RequestOptions DEFAULT_OPTIONS = new RequestOptions().centerCrop();

	private final RequestManager glide;
	private final int columns;
	private LessonSummary[] data;

	private RecyclerView recyclerView;

	public LessonsAdapter(final RequestManager glide, final int columns, final LessonSummary... data) {
		this.glide = glide;
		this.columns = columns;
		this.data = data == null ? new LessonSummary[0] : data;
	}

	@Override
	public void onAttachedToRecyclerView(final RecyclerView recyclerView) {
		super.onAttachedToRecyclerView(recyclerView);

		this.recyclerView = recyclerView;
	}

	@Override
	public final ViewHolder onCreateViewHolder(final ViewGroup parent, final int viewType) {
		final CardView view = (CardView)LayoutInflater.from(parent.getContext()).inflate(R.layout.main_lessons_recyclerview_item, parent, false);

		return new ViewHolder(view);
	}

	@Override
	public final void onBindViewHolder(final ViewHolder holder, final int position) {
		final LessonSummary lesson = data[position];

		glide.load(lesson.getPreviewURL()).apply(DEFAULT_OPTIONS).transition(DrawableTransitionOptions.withCrossFade()).into(holder.preview);
		holder.caption.setText(lesson.getPlaceholder());
		holder.caption.setAlpha(0f);
		holder.title.setText(lesson.getTitle());
		holder.description.setText(Utils.fromHtml(lesson.getDescription()));
		holder.checkOut.setTag(lesson.getLessonURL());

		if(columns == 1) {
			return;
		}

		holder.title.post(new Runnable() {

			@Override
			public void run() {
				adjustToHeight(position, holder);
			}

		});
	}

	@Override
	public final void onViewRecycled(final ViewHolder holder) {
		super.onViewRecycled(holder);
		glide.clear(holder.preview);
	}

	@Override
	public final int getItemCount() {
		return data.length;
	}

	/**
	 * Gets columns number for this RecyclerView.
	 *
	 * @return Columns number.
	 */

	public final int getColumnsNumber() {
		return columns;
	}

	/**
	 * Gets the adapter data.
	 *
	 * @return The adapter data.
	 */

	public final LessonSummary[] getData() {
		return data;
	}

	/**
	 * Sets the adapter data.
	 *
	 * @param data The adapter data.
	 */

	public final void setData(final LessonSummary... data) {
		this.data = data == null ? new LessonSummary[0] : data;
		notifyDataSetChanged();
	}

	/**
	 * Adjusts holder's title to other rows' title.
	 *
	 * @param position Current position.
	 * @param holder The current view holder.
	 */

	private void adjustToHeight(final int position, final ViewHolder holder) {
		if(columns == 2) {
			switch(position % columns) {
			case 1:
				adjustToHeight(holder, recyclerView.findViewHolderForAdapterPosition(position - 1));
				break;
			default:
				adjustToHeight(holder, recyclerView.findViewHolderForAdapterPosition(position + 1));
				break;
			}
		}
		else {
			switch(position % columns) {
			case 2:
				adjustToHeight(holder, recyclerView.findViewHolderForAdapterPosition(position - 1), recyclerView.findViewHolderForAdapterPosition(position - 2));
				break;
			case 1:
				adjustToHeight(holder, recyclerView.findViewHolderForAdapterPosition(position - 1), recyclerView.findViewHolderForAdapterPosition(position + 1));
				break;
			default:
				adjustToHeight(holder, recyclerView.findViewHolderForAdapterPosition(position + 1), recyclerView.findViewHolderForAdapterPosition(position + 2));
				break;
			}
		}
	}

	/**
	 * Adjusts holders title height.
	 *
	 * @param holders Holders title height.
	 */

	private void adjustToHeight(final RecyclerView.ViewHolder... holders) {
		int max = 0;

		for(final RecyclerView.ViewHolder holder : holders) {
			if(holder == null) {
				continue;
			}

			final int height = ((ViewHolder)holder).title.getHeight();
			if(max < height) {
				max = height;
			}
		}

		for(final RecyclerView.ViewHolder holder : holders) {
			if(holder == null) {
				continue;
			}
			((ViewHolder)holder).title.setHeight(max);
		}
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

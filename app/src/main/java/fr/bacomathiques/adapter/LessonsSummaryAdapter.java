package fr.bacomathiques.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.RequestManager;
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions;
import com.bumptech.glide.request.RequestOptions;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.RecyclerView;
import fr.bacomathiques.R;
import fr.bacomathiques.lesson.LessonSummary;
import fr.bacomathiques.util.Utils;

/**
 * An adapter that can contain lessons.
 */

public class LessonsSummaryAdapter extends RecyclerView.Adapter<LessonsSummaryAdapter.ViewHolder> {

	/**
	 * Default Glide options.
	 */

	// TODO: Make a placeholder.
	private static final RequestOptions DEFAULT_OPTIONS = new RequestOptions().centerCrop();

	/**
	 * The current glide instance.
	 */

	private final RequestManager glide;

	/**
	 * Number of columns to display.
	 */

	private final int columns;

	/**
	 * Summaries to display.
	 */

	private LessonSummary[] data;

	/**
	 * The parent recycler view.
	 */

	private RecyclerView recyclerView;

	/**
	 * Creates a new lessons adapter instance.
	 *
	 * @param glide The Glide instance.
	 * @param columns Number of columns to display.
	 * @param data Data to display.
	 */

	public LessonsSummaryAdapter(final RequestManager glide, final int columns, final LessonSummary... data) {
		this.glide = glide;
		this.columns = columns;
		this.data = data == null ? new LessonSummary[0] : data;
	}

	@Override
	public void onAttachedToRecyclerView(@NonNull final RecyclerView recyclerView) {
		super.onAttachedToRecyclerView(recyclerView);

		this.recyclerView = recyclerView;
	}

	@NonNull
	@Override
	public ViewHolder onCreateViewHolder(@NonNull final ViewGroup parent, final int viewType) {
		final CardView view = (CardView)LayoutInflater.from(parent.getContext()).inflate(R.layout.main_lessons_recyclerview_item, parent, false);
		return new ViewHolder(view);
	}

	@Override
	public void onBindViewHolder(@NonNull final ViewHolder holder, final int position) {
		holder.bind(position);
	}

	@Override
	public void onViewRecycled(@NonNull final ViewHolder holder) {
		super.onViewRecycled(holder);
		glide.clear(holder.preview);
	}

	@Override
	public int getItemCount() {
		return data.length;
	}

	/**
	 * Returns columns number for this RecyclerView.
	 *
	 * @return Columns number.
	 */

	public int getColumnsNumber() {
		return columns;
	}

	/**
	 * Returns the adapter data.
	 *
	 * @return The adapter data.
	 */

	public LessonSummary[] getData() {
		return data;
	}

	/**
	 * Sets the adapter data.
	 *
	 * @param data The adapter data.
	 */

	public void setData(final LessonSummary... data) {
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

	/**
	 * A lesson summary view holder.
	 */

	class ViewHolder extends RecyclerView.ViewHolder {

		/**
		 * The preview image.
		 */

		private ImageView preview;

		/**
		 * The caption.
		 */

		private TextView caption;

		/**
		 * The title.
		 */

		private TextView title;

		/**
		 * The description.
		 */

		private TextView description;

		/**
		 * The check out text view.
		 */

		private TextView checkOut;

		/**
		 * Creates a new view holder instance.
		 *
		 * @param view The card view.
		 */

		private ViewHolder(final CardView view) {
			super(view);

			this.preview = view.findViewById(R.id.main_lessons_recyclerview_item_preview);
			this.caption = view.findViewById(R.id.main_lessons_recyclerview_item_caption);
			this.title = view.findViewById(R.id.main_lessons_recyclerview_item_title);
			this.description = view.findViewById(R.id.main_lessons_recyclerview_item_description);
			this.checkOut = view.findViewById(R.id.main_lessons_recyclerview_item_checkout);
		}

		/**
		 * Binds the data at the specified position to the view.
		 *
		 * @param position The position.
		 */

		public void bind(final int position) {
			final LessonSummary lesson = data[position];

			glide.load(lesson.getPreviewURL()).apply(DEFAULT_OPTIONS).transition(DrawableTransitionOptions.withCrossFade()).into(preview);
			caption.setText(lesson.getPlaceholder());
			caption.setAlpha(0f);
			title.setText(lesson.getTitle());
			description.setText(Utils.fromHTML(lesson.getDescription()));
			checkOut.setTag(lesson.getLessonURL());

			title.setBackgroundColor(ContextCompat.getColor(title.getContext(), lesson.getTitle().endsWith("(Spécialité)") ? R.color.colorSpecialty : R.color.colorPrimary));

			if(columns == 1) {
				return;
			}

			title.post(() -> adjustToHeight(position, this));
		}

	}

}

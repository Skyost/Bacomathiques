/**
 * Represents an entry in a table of contents.
 */
export interface TocEntry {
    /**
     * The entry id.
     */
    id: string
    /**
     * The entry text.
     */
    text: string
    /**
     * The entry depth.
     */
    depth: number
    /**
     * The entry children.
     */
    children: TocEntry[]
}

/**
 * Represents a table of contents.
 */
export type Toc = TocEntry[]

files = list.files('content/',
  '[.](md|markdown|Rmd)$',
  full.names = TRUE,
  recursive = TRUE)

for (f in files) {
  blogdown:::process_file(f, function(x) {
    x <- gsub("published: false", "draft: true", x)
    x <- gsub("published: true", "", x)
    x
  })
}

for (f in files) {
  blogdown:::modify_yaml(
    f,
    slug = function(old, yaml) {
      gsub("content\\/\\/post\\/([0-9]+-[0-9]+-[0-9]+)-([a-z0-9A-Z-]+)\\.(md|Rmd)$",
        "\\2", f)
    },
    date = function(old, yaml) {
      gsub("content\\/\\/post\\/([0-9]+-[0-9]+-[0-9]+)-([a-z0-9A-Z-]+)\\.(md|Rmd)$",
        "\\1", f)
    },
    .keep_fields = c('title', 'subtitle', 'author', 'date', 'categories', 'tags', 'slug', 'draft'),
    .keep_empty = FALSE
  )
}

for (f in files) {
  blogdown:::modify_yaml(
    f,
    aliases = function(old, yaml) {
      .date <- gsub("content\\/\\/post\\/([0-9]+-[0-9]+-[0-9]+)-([a-z0-9A-Z-]+)\\.(md|Rmd)$",
        "\\1", f)
      .slug <- gsub("content\\/\\/post\\/([0-9]+-[0-9]+-[0-9]+)-([a-z0-9A-Z-]+)\\.(md|Rmd)$",
        "\\2", f)
      paste0(gsub("-", "/", .date), "/", .slug, ".html")
    },
    .keep_fields = c('title', 'subtitle', 'author', 'date', 'categories',
      'tags', 'slug', 'aliases', 'draft'),
    .keep_empty = FALSE
  )
}

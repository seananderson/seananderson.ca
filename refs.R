# TODO J.E.M. Flemming should be J.E. Mills Flemming
# TODO J.E. Mills Flemming needs to be fixed throughout refs.bib too
# TODO Earth2Oceans Derby needs to be manually fixed

# Need to fix all authors contributed equally and asterisks 

library("bibtex")
d <- read.bib("refs.bib")

ref <- list()

for(i in seq_along(d)) {
  name <- list()
  x <- d[[i]]
  # authors:
  for(j in seq_along(x$author)) {
    init <- paste0(paste(substr(x$author$given[[j]], 1, 1), collapse = "."), ".")
    family <- x$author$family[[j]]
    if(j == 1) {
      name[[j]] <- paste0(family, ", ", init)
      if(name[[j]] == "Anderson, S.C.") name[[j]] <- "**Anderson, S.C.**"
    } else {
      name[[j]] <- paste(init, family)
      if(name[[j]] == "S.C. Anderson") name[[j]] <- "**S.C. Anderson**"
    }
  }
  name0 <- paste0(paste0(name, collase = ""), collapse = ", ")

  vol_num_p <- ""
  if(!is.null(x$number) & !is.null(x$volume) & !is.null(x$pages)) {
    vol_num_p <- paste0(x$volume, "(", x$number, "): ", x$pages)
  }
  # no number:
  if(is.null(x$number) & !is.null(x$volume) & !is.null(x$pages)) {
    vol_num_p <- paste0(x$volume, ": ", x$pages)
  }
  # no pages:
  if(is.null(x$number) & !is.null(x$volume) & is.null(x$pages)) {
    vol_num_p <- paste0(x$volume, "(", x$number, ")")
  }
  # no number or pages:
  if(is.null(x$number) & !is.null(x$volume) & is.null(x$pages)) {
    vol_num_p <- x$volume
  }
  # no vol, number, or pages:
  if(is.null(x$number) & is.null(x$volume) & is.null(x$pages)) {
    vol_num_p <- ""
  }

  if(vol_num_p != "" & !vol_num_p %in% c("In review", "In revision", "Submitted")) {
    main <- paste0(paste0(name0, ". ", x$title, ". ", x$journal, ". ", vol_num_p), ".")
  } else {
    main <-paste0(name0, ". ", x$title, ". ", vol_num_p, ".")
  }

  if(!is.null(x$doi)) {
    main <- paste0(main, " <http://doi.org/", x$doi, ">")
  }

  if(!is.null(x$pdf)) {
    if(grepl("http", x$pdf)) {
      main <- paste0(main, " ([PDF](", x$pdf, ")).")
    } else {
      main <- paste0(main,
        " ([PDF](https://dl.dropboxusercontent.com/u/254940/papers/", x$pdf, ")).")
    }
  }

  if(!is.null(x$note)) {
    main <- paste0(main, " ", x$note, ".")
  }

  if(!is.null(x$altm)) {
    if(x$altm == "TRUE") {
    main <- paste0(main,
      "\n     <div class=\'altmetric-embed\' data-badge-type=\'1\' data-doi=\"",
      x$doi, "\"></div>")
    }
  }

  if(!is.null(x$f1000)) {
    main <- paste0(main,
      "\n     <a href=\"http://f1000.com/prime/",
      x$f1000,
      "\" target=\"_blank\"><img src=\"http://cdn.f1000.com.s3.amazonaws.com/images/badges/badgef1000.gif\" id=\"bg\"/></a>")
  }

  main <- paste0(x$year, "\n:    ", main)
  ref[[i]] <- main
}

ref <- paste(ref, collapse = "\n\n")
writeLines(ref, con = "papers.md")

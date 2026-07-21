BUILD_DATE="$(uname -v | sed 's/^#[0-9]* //')"
printf ' Built on %s\n' "$BUILD_DATE"
printf ' -----------------------------------------------------\n'

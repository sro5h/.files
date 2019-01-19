/* See LICENSE file for copyright and license details. */

/* colors */
static const char col_gray1[]       = "#032639";
static const char col_gray2[]       = "#232936";
static const char col_gray3[]       = "#323c4d";
static const char col_gray4[]       = "#9aa7bd";
static const char col_cyan[]        = "#608cc3";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray4, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_gray1, col_gray3 },
};

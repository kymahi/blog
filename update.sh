read -p "Enter Episode Date (yyyy-mm-dd): " date
read -p "Enter Episode #: " epNum
read -p "Enter Power Rankings week #: " rankingsWeek
read -p "Enter Episode Outline key: " outlineKey
read -p "Enter Power Rankings key: " rankingsKey

oldOutline=$(ls -1 _posts | grep outline.md | tail -n 1)
oldRankings=$(ls -1 _posts | grep -i "week-\d.md" | tail -n 1)

newOutline="$date"-episode-"$epNum"-outline.md
sed "s/document\/d\/e\/.*\/pub/document\/d\/e\/$outlineKey\/pub/g" _posts/"$oldOutline" > _posts/"$newOutline"
sed -E "s/pisode [0-9]+/pisode $epNum/gi" _posts/"$newOutline" > _posts/tempOutline
mv _posts/tempOutline _posts/"$newOutline"
sed "s/: true/: false/g" _posts/"$oldOutline" > _posts/tempOutline
mv _posts/tempOutline _posts/"$oldOutline"

newRankings="$date"-power-rankings-week-"$rankingsWeek".md
sed "s/spreadsheets\/d\/e\/.*\/pub/spreadsheets\/d\/e\/$rankingsKey\/pub/g" _posts/"$oldRankings" > _posts/"$newRankings"
sed -E "s/eek [0-9]+/eek $rankingsWeek/gi" _posts/"$newRankings" > _posts/tempRankings
mv _posts/tempRankings _posts/"$newRankings"
sed "s/: true/: false/g" _posts/"$oldRankings" > _posts/tempRankings
mv _posts/tempRankings _posts/"$oldRankings"

git add .
git commit -m "add episode $epNum outline and week $rankingsWeek power rankings"
git push origin HEAD
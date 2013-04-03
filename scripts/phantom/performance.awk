#!/usr/bin/awk -f

BEGIN		{
				count = 0
				sum = 0
			}
/SUCCESS/	{	count ++
				sum = sum + $4
			}
END			{
				print "Processed " count " rows"
				print "Average " sum / count "s"
			}

# Old DARP instances data format

## Branch and cut

Filename: described in paper, config-num_requests
Content:

```
a2-20

vehicle_count request_count ? ? ?
2 20 600 3 30

index   x_loc y_loc ?   loc min_time_minutes max_time_minutes
  0   0.000   0.000   0   0    0  600
  1  -4.374  -7.608   3   1    0 1440
  2  -1.990  -1.658   3   1    0 1440
  3  -6.500   8.666   3   1    0 1440


```
loc: 1- origin, -1 destination, 0-depot

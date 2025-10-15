# Plotly

Best resource seems to be David Fiedlers [docs](https://f-i-d-o.github.io/Manuals/Programming/Python/Plotly%20Manual/).

Import:
```python
import plotly.express as px       # for easy plotting
import plotly.graph_objects as go # for more control
```

## Plotly Express functions

Basic plot types:
```python
px.bar(df, x='x', y='y')
px.scatter(df, x='x', y='y')
px.line(df, x='x', y='y')
```
The methods can also be used with a Series as input, the index is x-axis, the values are y-axis.:
```python
px.line(series)
```

## Common parameters

Columns usage within single subplot:

- `x` and `y` are the columns to plot
- `color` is the column to color by, cretes a legend for the colors
- `line_group` Values from this column or array_like are used to group rows of data frame into lines. Only usable with [px.line](https://plotly.com/python-api-reference/generated/plotly.express.line.html).

Faceting - split the data into subplots:
- `facet_col` and `facet_row` are the columns to split the data by into columns and rows
- `facet_col_wrap` is the number of columns to wrap the facet columns into if using only `facet_col`

Styling:
- `labels` is a dictionary to name the axes, e.g. `labels={'x':'X-axis', 'y':'Y-axis'}`
- `title` is the title of the plot

Other options are available through the `update_layout` method:
```python
fig = px.line(df, x='x', y='y')
fig.update_layout(
    title='Title',
    xaxis_title='X-axis',
    yaxis_title='Y-axis',
    # xaxis=dict(title='X-axis', showgrid=False),
    # yaxis=dict(title='Y-axis', showgrid=False),
    # legend=dict(title='Legend', orientation='h', y=1.1, x=0.5),
    # margin=dict(l=0, r=0, t=0, b=0),
)
```

### Resizing
```python
fig = px.line(df, x='x', y='y')
fig.update_layout(
    autosize=False, 
    width=1500,
    height=1500,
)
```

## Plotly Graph Objects

Basic plot types:
```python
fig = go.Figure()
fig.add_trace(go.Bar(x=df['x'], y=df['y']))               # bar plot
fig.add_trace(go.Scatter(x=df['x'], y=df['y']))           # scatter plot
fig.add_trace(go.Scatter(x=df['x'], y=df['y'], mode='lines')) # line plot

```

### Common parameters

Single page reference of all the figure options is here: https://plotly.com/python/reference/

- `x` and `y` are the data to plot. With go, you have to provide the full data, not just the column names.
- `name` is the name of the trace, used in the legend and hover
- `mode` is the type of plot, e.g. 'lines', 'markers', 'lines+markers'
- `line` is a dictionary with line properties, e.g. `line=dict(color='red', width=2, dash='dash')`
- `marker` is a dictionary with marker properties, e.g. `marker=dict(color='red', size=10, symbol='circle')`
- `fill` is specific fill under/above the plot, 'tonexty' fills the area to the next y-value
- `fillcolor` is the color of the fill
- `showlegend` is a boolean to show the trace in the legend

Colors can have several formats:

- named colors, e.g. `red`, `blue`. The ccs list is disscussed [here](https://community.plotly.com/t/plotly-colours-list/11730)
- hex, e.g. `#444` 
- rgb, e.g. `rgb(68, 68, 68)`
- rgb with alpha, e.g. `rgba(68, 68, 68, 0.3)` for semi-transparent gray


### Plotly recepies

#### Line plot with error bands
```python
# mean, std and median are series with the same index
fig = go.Figure()
fig.add_trace(go.Scatter(x = mean.index, y=mean, mode='lines', name='mean')) 
fig.add_trace(go.Scatter(x = median.index, y=median, mode='lines', name='median', line=dict(dash='dash'))) 
fig.add_trace(go.Scatter(x = mean.index, y=mean+std, mode='lines', name='Upper std', 
                         marker=dict(color="#444"), line=dict(width=0), showlegend=False))
fig.add_trace(go.Scatter(x = mean.index, y=mean-std, mode='lines', name='Lower std', 
                         marker=dict(color="#444"), line=dict(width=0), fillcolor='rgba(68, 68, 68, 0.3)', fill='tonexty',  showlegend=False)) # fill 'tonexty' to fill "to next y", meaning the one before it
fig.update_layout(
    yaxis_title='y-label',
    title='Title',
    hovermode="x"
)
```



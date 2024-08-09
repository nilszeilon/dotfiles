from typing import List
from kitty.boss import Boss
import plotly.express as px
import pandas as pd
import plotly.io as pio
import plotly


plotly.io.orca.config.executable = '/usr/bin/orca'

def main(args: List[str]) -> str:
    # Create sample data
    data = {
        'x': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        'y': [2, 4, 1, 5, 3, 7, 6, 8, 9, 10],
        'category': ['A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B']
    }
    df = pd.DataFrame(data)
    
    # Create a scatter plot using Plotly Express
    fig = px.scatter(df, x='x', y='y', color='category', title='Sample Scatter Plot')
    
    # Update layout for better appearance
    fig.update_layout(
        xaxis_title='X-axis',
        yaxis_title='Y-axis',
        legend_title='Category'
    )

    # Use orca to render the image
    pio.write_image(fig, "scatter_plot.jpeg", engine="orca")

    return "Plot saved as scatter_plot.jpeg"

def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # get the kitty window into which to paste answer
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        boss.call_remote_control(w, ('kitten', 'icat', f'--match=id:{w.id}', 'scatter_plot.jpeg'))

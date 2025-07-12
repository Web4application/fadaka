from flask import Flask, render_template, request
from launch_miner import launch_srbminer

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def config():
    if request.method == 'POST':
        wallet = request.form['wallet']
        pool = request.form['pool']
        algorithm = request.form['algorithm']
        boost = request.form['boost']
        launch_srbminer(algorithm, pool, wallet, boost)
        return "✅ Miner launched!"
    return '''
        <form method="post">
            Wallet: <input name="wallet"><br>
            Pool: <input name="pool"><br>
            Algorithm: <input name="algorithm" value="ethash"><br>
            GPU Boost: <input name="boost" value="5"><br>
            <input type="submit" value="Start Mining">
        </form>
    '''

if __name__ == '__main__':
    app.run(debug=True)

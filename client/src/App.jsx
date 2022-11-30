import AppleShop from "./component/AppleShop";
import useWeb3 from "./hooks/useWeb3";

function App() {
  const [web3, account] = useWeb3();
  return (
    <div className="App w-screen h-screen flex items-center bg-slate-900">
      <div className=" w-[360px]  bg-yellow -300 mx-auto my-auto">
        <AppleShop web3={web3} account={account}></AppleShop>
      </div>
    </div>
  );
}

export default App;

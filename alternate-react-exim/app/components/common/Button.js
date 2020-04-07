import Spinner from 'components/common/Spinner';

export default ({ loading, className, onClick, children}) => {
  return <button className={"button " + (className || '')} onClick={onClick} disabled={loading}>
    {loading ? <Spinner /> : children}
  </button>;
};

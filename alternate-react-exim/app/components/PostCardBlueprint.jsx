import React from 'react';
import {Link} from 'react-router';
import Avatar from 'components/common/Avatar';

export default ({ user, authorAddition, metadata, children }) => {
  const userUrl = '/@' + user.login;

  return <article className="post">
    <Link className="post-avatar-container" to={userUrl}>
      <Avatar className="post-avatar" url={user.avatar_url} />
    </Link>
    <div className="post-content">
      <div className="post-header">
        <Link className="post-author" to={userUrl}>{user.login}</Link> {authorAddition}
        <span className="post-metadata">{metadata}</span>
      </div>
      {children}
    </div>
  </article>
};

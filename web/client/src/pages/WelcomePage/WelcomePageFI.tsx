import React from 'react';
import { IPageTemplateExtended } from '../../interfaces/IPageTemplateExtended';

const WelcomePage = ({content, about}: IPageTemplateExtended) => {
    return (
        <>
            {content}
            {about}
        </>
    )
}

export default WelcomePage;
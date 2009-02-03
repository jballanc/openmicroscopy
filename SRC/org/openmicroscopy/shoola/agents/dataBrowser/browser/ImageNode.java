/*
 * org.openmicroscopy.shoola.agents.dataBrowser.browser.ImageNode 
 *
 *------------------------------------------------------------------------------
 *  Copyright (C) 2006-2008 University of Dundee. All rights reserved.
 *
 *
 * 	This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 *------------------------------------------------------------------------------
 */
package org.openmicroscopy.shoola.agents.dataBrowser.browser;


//Java imports
import java.awt.Dimension;
import java.awt.event.MouseListener;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.Date;

//Third-party libraries

//Application-internal dependencies
import pojos.ImageData;

/** 
 * Represents a leaf in the composite structure used to visualize an
 * image hierarchy.
 *
 * @see ImageDisplay
 *
 * @author  Jean-Marie Burel &nbsp;&nbsp;&nbsp;&nbsp;
 * <a href="mailto:j.burel@dundee.ac.uk">j.burel@dundee.ac.uk</a>
 * @author Donald MacDonald &nbsp;&nbsp;&nbsp;&nbsp;
 * <a href="mailto:donald@lifesci.dundee.ac.uk">donald@lifesci.dundee.ac.uk</a>
 * @version 3.0
 * <small>
 * (<b>Internal version:</b> $Revision: $Date: $)
 * </small>
 * @since OME3.0
 */
public class ImageNode     
	extends ImageDisplay
{
    
    /** Bound property indicating a classification visualization. */
    public final static String     CLASSIFY_NODE_PROPERTY = "classifyNode";

    /** Bound property indicating to pint the thumbnail. */
    public final static String     PIN_THUMBNAIL_PROPERTY = "pinThumbnail";

    /** The left element displayed before the acquisition date. */
    private final static String		LEFT =" (";
    
    /** The right element displayed before the acquisition date. */
    private final static String		RIGHT =")";
    
    /** The thumbnail this node is going to display. */
    private Thumbnail       thumbnail;
    
    /** The component on which the thumbnail is painted. */
    private ThumbnailCanvas canvas;
    
    /**
     * Implemented as specified by superclass.
     * @see ImageDisplay#doAccept(ImageDisplayVisitor)
     */
    protected void doAccept(ImageDisplayVisitor visitor)
    {
        visitor.visit(this);
    }

    /** Pins the thumbnail on the board. */
    void pinThumbnail()
    {
    	firePropertyChange(PIN_THUMBNAIL_PROPERTY, null, this);
    }
    
    /**
     * Creates a new leaf node.
     * 
     * @param title             The frame's title.
     * @param hierarchyObject   The original object in the image hierarchy which
     *                          is visualized by this node. It has to be an 
     *                          image object in this case. 
     *                          Never pass <code>null</code>.
     * @param t                 The thumbnail this node is going to display. 
     *                          This is obviously a thumbnail for the image
     *                          object this node represents.
     */
    public ImageNode(String title, Object hierarchyObject, Thumbnail t)
    {
        super(title, "", hierarchyObject);
        //Probably cleaner to use a visitor but for performance reason better
        //that way.
        setTitle(getPartialName(title+LEFT+getFormattedAcquisitionTime()+
        						RIGHT));
        setNodeDecoration();
        setTitleBarType(SMALL_BAR);
        //if (t == null) throw new NullPointerException("No thumbnail.");
        thumbnail = t;
        if (t != null) {
        	canvas = new ThumbnailCanvas(this);
            getInternalDesktop().add(canvas, Integer.valueOf(0));
            setCanvasSize(t.getWidth(), t.getHeight());
            //setCanvasToolTip(getNodeName());
            setCanvasToolTip(getTitle());
        }
    }
    
    /**
     * Adds a {@link MouseListener} to the components composing the 
     * node.
     * 
     * @param listener The listener to add.
     */
    public void addMouseListenerToComponents(MouseListener listener)
    {
    	 getTitleBar().addMouseListener(listener);
    	 //addMouseListener(listener);
    	 if (canvas != null) canvas.addMouseListener(listener);
    }
    
    /** Fired a property change event to bring up the classification widget. */
    public void fireClassification()
    {
        firePropertyChange(CLASSIFY_NODE_PROPERTY, null, this);
    }
    
    /**
     * Spits out a runtime exception because it's not possible to add a
     * child to a leaf node.
     * 
     * @param child The child to add. In this case, a runtime exception is 
     * 				thrown.
     */
    public void addChildDisplay(ImageDisplay child)
    {
        throw new IllegalArgumentException(
                "Can't add a child to an ImageNode.");
    }
    
    /**
     * Always returns <code>false</code> as this is not a container node.
     * @see ImageDisplay#containsImages()
     */
    public boolean containsImages() { return false; }

    /**
     * Returns the thumbnail hosted by this class.
     * 
     * @return See above.
     */
    public Thumbnail getThumbnail() { return thumbnail; }
    
    /**
     * Returns the time of acquisition or the actual time if information
     * not available.
     * 
     * @return See above.
     */
    public Timestamp getAcquisitionTime()
    {
    	Timestamp t = ((ImageData) getHierarchyObject()).getAcquisitionDate();
    	if (t == null) t = new Timestamp(new Date().getTime());
    	return t;
    }
    
    /**
     * Returns the time of acquisition or the actual time if information
     * not available.
     * 
     * @return See above.
     */
    public String getFormattedAcquisitionTime()
    {
        return DateFormat.getDateInstance().format(getAcquisitionTime()); 
    }

    
    /** 
     * Sets the size of the {@link ThumbnailCanvas} and the preferred size of
     * the internal desktop.
     * 
     * @param w The width of the canvas.
     * @param h The height of the canvas.
     */
    public void setCanvasSize(int w, int h)
    {
    	if (canvas != null) canvas.setBounds(0, 0, w, h);
        getInternalDesktop().setSize(w, h);
        getInternalDesktop().setPreferredSize(new Dimension(w, h));
    }

    /**
     * Sets the tool tip of the {@link #canvas}.
     * 
     * @param text The value to set.
     */
    public void setCanvasToolTip(String text)
    {
    	if (canvas != null) canvas.setToolTipText(text);
    }
    
    /**
     * Makes a copy of the node.
     * 
     * @return See above.
     */
    public ImageNode copy()
    {
    	ImageNode img = new ImageNode(getTitle(), getHierarchyObject(), 
    								getThumbnail());
    	if (canvas != null) 
    		img.setCanvasSize(canvas.getWidth(), canvas.getHeight());
    	return img;
    }

    /** 
     * Overrides the <code>setSize(int, int)</code> method, otherwise
     * after collapsing the node, we can resize the node.
     * @see ImageDisplay#setSize(int, int)
     */
    public void setSize(int w, int h)
    {
        super.setSize(w, h);
        setResizable(false);
    }
    
}
